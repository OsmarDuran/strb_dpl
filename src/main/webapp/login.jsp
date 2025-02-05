<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Rutas Barrido</title>
    <link rel="icon" href="images/icons/favicon.png" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/logins.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;900&display=swap" rel="stylesheet">
    <script defer src="js/login_script.js"></script>
</head>
<body>
<div class="container" id="container">
    <!-- Inicio de Sesión -->
    <div class="form-container sign-in-container">
        <form action="LoginServlet" method="post">
            <h1>Inicia Sesión</h1>
            <input type="email" name="email" placeholder="Correo electrónico" required />
            <input type="password" name="password" placeholder="Contraseña" required />
            <button type="submit">Iniciar Sesión</button>
            <% if (request.getParameter("error") != null) { %>
            <p style="color:red;">Correo o contraseña incorrectos</p>
            <% } %>
        </form>
    </div>

    <!-- Registro de Cuenta -->
    <div class="form-container sign-up-container">
        <form action="RegistrarUsuarioServlet" method="post" onsubmit="return validarRegistro();">
            <h1>Crear Cuenta</h1>
            <span>Completa tus datos para registrarte</span>
            <input type="text" name="nombre" id="nombre" placeholder="Nombre(s)" required />
            <input type="text" name="apellido" id="apellido" placeholder="Apellido(s)" required />
            <input type="email" name="email" id="email" placeholder="Correo electrónico" required />
            <input type="password" name="password" id="password" placeholder="Contraseña" required />
            <!-- Campo oculto para establecer siempre el rol como Cliente -->
            <input type="hidden" name="rol" value="1" />
            <button type="submit">Crear Cuenta</button>
        </form>
    </div>

    <!-- Panel de Overlay -->
    <div class="overlay-container">
        <div class="overlay">
            <div class="overlay-panel overlay-left">
                <h1>¡Bienvenido de nuevo!</h1>
                <p>Ingresa tus credenciales para continuar con tu cuenta</p>
                <button class="ghost" id="signIn">Iniciar Sesión</button>
            </div>
            <div class="overlay-panel overlay-right">
                <h1>¡Hola!</h1>
                <p>Regístrate y empieza a disfrutar de los beneficios de STRB</p>
                <button class="ghost" id="signUp">Registrarse</button>
            </div>
        </div>
    </div>
</div>

<footer>
    <p>
        © 2025 STRB. Todos los derechos reservados 2025 H. Ayuntamiento de Orizaba, Ver.
    </p>
</footer>

<script>
    // Validación del formulario de registro
    function validarRegistro() {
        const nombre = document.getElementById("nombre").value.trim();
        const apellido = document.getElementById("apellido").value.trim();
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();

        if (!nombre || !apellido || !email || !password) {
            alert("Por favor, completa todos los campos obligatorios.");
            return false;
        }

        return true;
    }
</script>

</body>
</html>
