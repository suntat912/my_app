const express = require('express');
const mysql = require('mysql2');
const bcrypt = require('bcrypt');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// Kết nối MySQL
const db = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',   // Thay bằng user của bạn
    password: '1234',   // Nếu có mật khẩu thì điền vào
    database: 'user_db'
});

db.connect(err => {
    if (err) {
        console.error('Lỗi kết nối MySQL:', err);
    } else {
        console.log('Kết nối MySQL thành công');
    }
});

// Xử lý đăng ký
app.post('/register', async (req, res) => {
    const { username, email, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);

    const sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
    db.query(sql, [username, email, hashedPassword], (err, result) => {
        if (err) {
            return res.status(400).json({ message: "Lỗi đăng ký", error: err });
        }
        res.json({ message: "Đăng ký thành công" });
    });
});

// Xử lý đăng nhập
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    const sql = "SELECT * FROM users WHERE username = ?";

    db.query(sql, [username], async (err, results) => {
        if (err || results.length === 0) {
            return res.status(401).json({ message: "Sai tài khoản hoặc mật khẩu" });
        }

        const user = results[0];
        const isMatch = await bcrypt.compare(password, user.password);

        if (isMatch) {
            res.json({ message: "Đăng nhập thành công", user });
        } else {
            res.status(401).json({ message: "Sai tài khoản hoặc mật khẩu" });
        }
    });
});

// Chạy server
app.listen(3000, () => {
    console.log("Server chạy trên cổng 3000");
});
