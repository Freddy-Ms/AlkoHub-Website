import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import Cookies from 'js-cookie';
import '../styles/Login.css';
import '../styles/styles.css';

const Login = () => {
  const [formData, setFormData] = useState({
    nazwa: '',
    haslo: '',
  });
  const [errorMessage, setErrorMessage] = useState('');
  const navigate = useNavigate();

  const handleLoginChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const loginUser = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch('http://localhost:5000/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData),
      });

      const data = await response.json();
      if (response.ok) {
        Cookies.set('user_id', data.user_id, { expires: 1 });
        Cookies.set('role', data.user_ranga, { expires: 1 });
        navigate('/'); 
        window.location.reload();
      } else {
        setErrorMessage(data.message);
      }
    } catch (error) {
      alert('Wystąpił błąd podczas logowania.');
    }
  };

  return (
    <div className="login-container">
      <h1>Logowanie</h1>
      <form onSubmit={loginUser}>
        <input
          type="Login_text"
          name="nazwa"
          placeholder="Nazwa użytkownika"
          value={formData.nazwa}
          onChange={handleLoginChange}
          required
        />
        <input
          type="password"
          name="haslo"
          placeholder="Hasło"
          value={formData.haslo}
          onChange={handleLoginChange}
          required
        />
        <button type="submit" className="primary-button">Zaloguj się</button>
      </form>
      {errorMessage && <p className="Login_error-message">{errorMessage}</p>}
      <div className="Login_navigation">
        <span className="Login_text">Nie masz konta?</span>
        <Link to="/register">Zarejestruj się</Link>
      </div>
    </div>
  );
};

export default Login;
