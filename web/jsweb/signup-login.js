document.addEventListener("DOMContentLoaded", function () {
    const registerBtn = document.querySelector(".register-btn");
    const loginBtn = document.querySelector(".login-btn");
    const container = document.querySelector(".container");

    // Chuyển đổi giữa Login & Register
    registerBtn.addEventListener("click", () => {
        container.classList.add("active");
    });

    loginBtn.addEventListener("click", () => {
        container.classList.remove("active");
    });

    // Lưu trữ dữ liệu người dùng
    let users = JSON.parse(localStorage.getItem("users")) || [];

    // Xử lý đăng ký
    document.querySelector(".register form").addEventListener("submit", function (e) {
        e.preventDefault();

        const username = this.querySelector("input[type='text']").value;
        const email = this.querySelector("input[type='email']").value;
        const password = this.querySelector("input[type='password']").value;

        if (users.some(user => user.username === username)) {
            alert("Tên đăng nhập đã tồn tại!");
            return;
        }

        users.push({ username, email, password });
        localStorage.setItem("users", JSON.stringify(users));

        alert("Đăng ký thành công! Hãy đăng nhập.");
        this.reset();
        container.classList.remove("active");
    });

    // Xử lý đăng nhập
    document.querySelector(".login form").addEventListener("submit", function (e) {
        e.preventDefault();

        const username = this.querySelector("input[type='text']").value;
        const password = this.querySelector("input[type='password']").value;

        const user = users.find(user => user.username === username && user.password === password);

        if (user) {
            alert("Đăng nhập thành công!");
            localStorage.setItem("loggedInUser", username);
            window.location.href = "home.html"; // Điều hướng sau khi đăng nhập thành công
        } else {
            alert("Tên đăng nhập hoặc mật khẩu không đúng!");
        }
    });
});
