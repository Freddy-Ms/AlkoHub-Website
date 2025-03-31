import React, { useState } from 'react';

const AdminPage = () => {
  const [alcohols, setAlcohols] = useState([]);
  const [newAlcohol, setNewAlcohol] = useState('');
  const [users, setUsers] = useState([]);
  const [newRole, setNewRole] = useState('');
  const [comments, setComments] = useState([]);
  const addAlcohol = () => {
    setAlcohols([...alcohols, newAlcohol]);
    setNewAlcohol('');
  };
  const removeAlcohol = (index) => {
    setAlcohols(alcohols.filter((_, i) => i !== index));
  };

  const editAlcohol = (index) => {
    const newName = prompt('Nowa nazwa:', alcohols[index]);
    if (newName) {
      const updatedAlcohols = [...alcohols];
      updatedAlcohols[index] = newName;
      setAlcohols(updatedAlcohols);
    }
  };

  const changeUserRole = (id) => {
    setUsers(users.map((user) =>
      user.id === id ? { ...user, role: newRole } : user
    ));
    setNewRole('');
  };

  const removeUserRole = (id) => {
    setUsers(users.map((user) =>
      user.id === id ? { ...user, role: 'User' } : user
    ));
  };

  const removeComment = (id) => {
    setComments(comments.filter((comment) => comment.id !== id));
  };

  return (
    <div className="admin-panel">
      <h1>Panel Administratora</h1>

      <div>
        <h2>Alkohole</h2>
        <input 
          type="text" 
          value={newAlcohol} 
          onChange={(e) => setNewAlcohol(e.target.value)} 
          placeholder="Nowy alkohol" 
        />
        <button onClick={addAlcohol}>Dodaj Alkohol</button>

        <ul>
          {alcohols.map((alcohol, index) => (
            <li key={index}>
              {alcohol} 
              <button onClick={() => editAlcohol(index)}>Edytuj</button>
              <button onClick={() => removeAlcohol(index)}>Usuń</button>
            </li>
          ))}
        </ul>
      </div>

      <div>
        <h2>Użytkownicy</h2>
        <input 
          type="text" 
          value={newRole} 
          onChange={(e) => setNewRole(e.target.value)} 
          placeholder="Nowa ranga" 
        />
        <ul>
          {users.map((user) => (
            <li key={user.id}>
              {user.name} - {user.role}
              <button onClick={() => changeUserRole(user.id)}>Zmień Rangę</button>
              <button onClick={() => removeUserRole(user.id)}>Usuń Rangę</button>
            </li>
          ))}
        </ul>
      </div>

      <div>
        <h2>Komentarze</h2>
        <ul>
          {comments.map((comment) => (
            <li key={comment.id}>
              {comment.text}
              <button onClick={() => removeComment(comment.id)}>Usuń Komentarz</button>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default AdminPage;