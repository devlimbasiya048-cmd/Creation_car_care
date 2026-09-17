<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="creation_car_care.Admin.Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Portal Login - Creation Car Care</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }
        body, html {
            margin: 0;
            padding: 0;
            background-color: #f8fafc;
            min-height: 100vh;
        }
        /* Dark Top Wave Header (Matching Screenshot 1 Frame 1) */
        .admin-hero-top {
            background-color: #111827;
            height: 290px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            border-bottom-left-radius: 40px;
            border-bottom-right-radius: 40px;
            box-shadow: 0 10px 30px rgba(17, 24, 39, 0.2);
            text-align: center;
            padding-bottom: 40px;
        }
        .portal-logo-wrap {
            width: 58px;
            height: 58px;
            border-radius: 14px;
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px;
            box-shadow: 0 4px 15px rgba(234, 88, 12, 0.25);
        }
        .portal-logo-wrap img {
            width: 44px;
            height: 44px;
            border-radius: 8px;
            object-fit: cover;
        }
        .admin-hero-top h2 {
            margin: 0 0 4px 0;
            font-size: 19px;
            font-weight: 800;
            color: #ffffff;
            letter-spacing: 1px;
        }
        .admin-hero-top span {
            font-size: 11px;
            color: #ea580c;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }
        /* Centered White Card */
        .login-card-container {
            max-width: 440px;
            margin: -90px auto 50px auto;
            padding: 0 16px;
        }
        .login-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 38px 36px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            border: 1px solid #e2e8f0;
        }
        .card-header-text h3 {
            margin: 0 0 6px 0;
            font-size: 22px;
            font-weight: 800;
            color: #0f172a;
        }
        .card-header-text p {
            margin: 0 0 24px 0;
            font-size: 13px;
            color: #64748b;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-label {
            display: block;
            font-size: 12.5px;
            font-weight: 700;
            color: #334155;
            margin-bottom: 6px;
        }
        .form-input {
            width: 100%;
            padding: 12px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 10px;
            font-size: 13.5px;
            color: #0f172a;
            outline: none;
            transition: border-color 0.2s;
            box-sizing: border-box;
        }
        .form-input:focus {
            border-color: #ea580c;
            box-shadow: 0 0 0 3px rgba(234, 88, 12, 0.15);
        }
        .remember-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
            font-size: 12.5px;
            color: #64748b;
        }
        .remember-label {
            display: flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
            font-weight: 600;
        }
        .btn-secure-login {
            width: 100%;
            background: #ea580c;
            color: #ffffff;
            border: none;
            padding: 13px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 800;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: background 0.2s;
            box-shadow: 0 4px 15px rgba(234, 88, 12, 0.3);
        }
        .btn-secure-login:hover {
            background: #c2410c;
        }
        .alert-box {
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 12.5px;
            font-weight: 600;
            margin-bottom: 18px;
            display: block;
        }
        .alert-danger {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }
        .back-to-site {
            text-align: center;
            margin-top: 18px;
        }
        .back-to-site a {
            color: #64748b;
            font-size: 12.5px;
            font-weight: 600;
            text-decoration: none;
        }
        .back-to-site a:hover {
            color: #ea580c;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Top Wave Header -->
        <div class="admin-hero-top">
            <div class="portal-logo-wrap">
                <img src="../Images/studio_logo.jpeg" alt="Logo" />
            </div>
            <h2>CREATION CAR CARE</h2>
            <span>DETAILING STUDIO PORTAL</span>
        </div>

        <!-- Centered Login Card -->
        <div class="login-card-container">
            <div class="login-card">
                <div class="card-header-text">
                    <h3>Welcome Back</h3>
                    <p>Enter your credentials to access admin studio portal.</p>
                </div>

                <asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert-box alert-danger"></asp:Label>

                <div class="form-group">
                    <label class="form-label">Email ID</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" Text="admin@creation.com" placeholder="admin@creation.com"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label class="form-label">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-input" placeholder="••••••••"></asp:TextBox>
                </div>

                <div class="remember-row">
                    <label class="remember-label">
                        <asp:CheckBox ID="chkRemember" runat="server" Checked="true" />
                        Remember me
                    </label>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="SECURE LOGIN" OnClick="btnLogin_Click" CssClass="btn-secure-login" />

                <div class="back-to-site">
                    <a href="../Home.aspx">&larr; Back to Customer Website</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
