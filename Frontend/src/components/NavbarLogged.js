import React from 'react';
import { Link } from 'react-router-dom';
import Cookies from 'js-cookie';
import '../styles/Navbar.css';
import '../styles/styles.css';

const NavbarLogged = () => {

  const logoutUser = async () => {
    try {
      const response = await fetch('http://localhost:5000/logout', { method: 'POST' });
      if (response.ok) {
        Cookies.remove('user_id');
        Cookies.remove('role');
        alert('Wylogowano pomyślnie!');
        window.location.href = 'http://localhost:3000';
      } else {
        alert('Błąd wylogowania.');
      }
    } catch (error) {
      alert('Wystąpił błąd podczas wylogowania.');
    }
  };

  return (
    <nav className="navbar">
      <div className="auth-buttons">
        <Link to="/history">
          <button className="primary-button">🥃</button>
        </Link>
        <Link to="/achievements">
          <button className="primary-button">🏆</button>
        </Link>
        <Link to="/liked">
          <button className="primary-button">❤️</button>
        </Link>
      </div>
        <Link to="/" className="no-underline">
            <h1 className="navbar-text">AlkoHub</h1>
        </Link>
      <div className="auth-buttons">
        <button onClick={logoutUser} className={"primary-button"}>Wyloguj</button>
        <Link to="/profile">
          <button className="primary-button">👤</button>
        </Link>
      </div>
    </nav>
  );
};

export default NavbarLogged;
