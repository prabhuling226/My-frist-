from flask import Flask, render_template, request, redirect, session, flash
from database.db import get_db
from utils.validators import *
from config import Config
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
import os
from datetime import datetime

app = Flask(__name__)
app.config.from_object(Config)
app.secret_key = Config.SECRET_KEY

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/')
def index():
    if 'user' in session:
        return redirect('/home')
    return render_template('login.html')


@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        fname = request.form['first_name']
        lname = request.form['last_name']
        dob = request.form['dob']
        email = request.form['email']
        password = request.form['password']
        confirm = request.form['confirm_password']

        if not is_safe_name(fname) or not is_safe_name(lname):
            flash("Invalid name")
            return redirect('/signup')

        if not is_valid_email(email):
            flash("Invalid email")
            return redirect('/signup')

        if password != confirm:
            flash("Passwords do not match")
            return redirect('/signup')

        if not is_strong_password(password):
            flash("Weak password")
            return redirect('/signup')

        file = request.files['profile_pic']
        if not file or not allowed_file(file.filename):
            flash("Invalid image")
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
        except:
            flash("Email already exists")
            return redirect('/signup')
        finally:
            conn.close()

        flash("Signup successful!")
        return redirect('/login')

    return render_template('signup.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        conn = get_db()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("SELECT * FROM users WHERE email=%s", (email,))
        user = cursor.fetchone()

        if user and check_password_hash(user['password'], password):
            session['user'] = user['email']

            cursor.execute("UPDATE users SET last_login=%s WHERE email=%s",
                           (datetime.now(), email))
            conn.commit()

            return redirect('/home')

        flash("Invalid credentials")
        return redirect('/login')

    return render_template('login.html')


@app.route('/home')
def home():
    if 'user' not in session:
        return redirect('/login')
    return render_template('home.html', user=session['user'])


@app.route('/logout')
def logout():
    session.clear()
    return redirect('/login')


# 🔥 NGROK INTEGRATION (IMPORTANT)
if __name__ == "__main__":
    from pyngrok import ngrok

    # close old tunnels (important)
    ngrok.kill()

    public_url = ngrok.connect(5000)
    print("\n🔥 PUBLIC URL:", public_url, "\n")

    app.run(debug=True, use_reloader=False)