from flask import Flask, render_template, request, redirect, session, flash
from database.db import get_db
from utils.validators import is_valid_email, is_strong_password, is_safe_name
from config import Config
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
import os
from datetime import datetime

app = Flask(__name__)
app.config.from_object(Config)
app.secret_key = Config.SECRET_KEY

# Ensure upload folder exists
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


# 🌐 Landing Page
@app.route('/')
def index():
    if 'user' in session:
        return redirect('/home')
    return render_template('login.html')


# 🔐 SIGNUP
@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        fname = request.form.get('first_name')
        lname = request.form.get('last_name')
        dob = request.form.get('dob')
        email = request.form.get('email')
        password = request.form.get('password')
        confirm = request.form.get('confirm_password')

        # Validation
        if not is_safe_name(fname) or not is_safe_name(lname):
            flash("Invalid name format")
            return redirect('/signup')

        if not is_valid_email(email):
            flash("Invalid email")
            return redirect('/signup')

        if password != confirm:
            flash("Passwords do not match")
            return redirect('/signup')

        if not is_strong_password(password):
            flash("Password must be at least 6 characters")
            return redirect('/signup')

        file = request.files.get('profile_pic')
        if not file or file.filename == '' or not allowed_file(file.filename):
            flash("Invalid or missing profile image")
            return redirect('/signup')

        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)

        hashed_password = generate_password_hash(password)

        conn = get_db()
        cursor = conn.cursor()

        try:
            cursor.execute("""
                INSERT INTO users (first_name, last_name, dob, email, password, profile_pic)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (fname, lname, dob, email, hashed_password, filename))
            conn.commit()
        except Exception as e:
            flash("Email already exists or DB error")
            return redirect('/signup')
        finally:
            conn.close()

        flash("Signup successful! Please login.")
        return redirect('/login')

    return render_template('signup.html')


# 🔐 LOGIN
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')

        conn = get_db()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("SELECT * FROM users WHERE email=%s", (email,))
        user = cursor.fetchone()

        if user and check_password_hash(user['password'], password):
            session['user'] = user['email']

            # Update last login
            cursor.execute(
                "UPDATE users SET last_login=%s WHERE email=%s",
                (datetime.now(), email)
            )
            conn.commit()

            return redirect('/home')

        flash("Invalid credentials")
        return redirect('/login')

    return render_template('login.html')


# 🏠 HOME (Protected)
@app.route('/home')
def home():
    if 'user' not in session:
        return redirect('/login')

    return render_template('home.html', user=session['user'])


# 🚪 LOGOUT
@app.route('/logout')
def logout():
    session.clear()
    return redirect('/login')


# 🚀 PRODUCTION RUN (RENDER COMPATIBLE)
if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)