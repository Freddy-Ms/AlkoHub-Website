import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import Cookies from 'js-cookie';
import '../styles/ProductDetail.css';
const role = Cookies.get("role");
const userId = Cookies.get('user_id');

const ProductDetail = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [productData, setProductData] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const [liked, setLiked] = useState(false); 
  const [isLoggedIn, setIsLoggedIn] = useState(false); 
  const [showAddOpinion, setShowAddOpinion] = useState(false); 
  const [newOpinion, setNewOpinion] = useState({ ocena: 0, recenzja: '' }); 
  const [hoverRating, setHoverRating] = useState(null);
  const [isAdmin, setIsAdmin] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [alcoholTypes, setAlcoholTypes] = useState([]);
  const [editedAlcohol, setEditedAlcohol] = useState({
    nazwa: '',
    rodzaj: '',
    zawartosc_procentowa: '',
    rok_produkcji: '',
    opis: '',
  });
  const [hasOpinion, setHasOpinion] = useState(false);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    const fetchProductDetails = async () => {
      try {
        const response = await fetch(`http://localhost:5000/get_product_details/${id}`);
        if (!response.ok) throw new Error('Nie udało się pobrać szczegółów produktu');
        const data = await response.json();
        setProductData(data);

        if (userId) {
          setIsLoggedIn(true);
          const likeResponse = await fetch(`http://localhost:5000/is_favorite/${userId}/${id}`);
          const likeData = await likeResponse.json();
          setLiked(likeData.is_favorite);
        }
      } catch (err) {
        setError(err.message);
      } finally {
        setIsLoading(false);
      }
    };

    fetchProductDetails();
  }, [id]);

  useEffect(() => {
    const fetchAlcoholTypes = async () => {
      try {
        const response = await fetch('http://localhost:5000/alcohol_types');
        if (!response.ok) {
          throw new Error('Błąd podczas pobierania rodzajów alkoholu');
        }
        const data = await response.json();
        setAlcoholTypes(data);
      } catch (error) {
        console.error('Error fetching alcohol types:', error);
      }
    };

    fetchAlcoholTypes();
  }, []);

  useEffect(() => {
    if (role === 'Administrator') {
      setIsAdmin(true);
    }
    if (role) {
      setIsLoggedIn(true);
    }
  }, []);

  useEffect(() => {
    const checkUserOpinion = async () => {
      try {
        setLoading(true);
        const response = await fetch(`http://localhost:5000/check_user_opinion/${userId}/${id}`);
        const data = await response.json();

        if (data.exists) {
          setHasOpinion(true);
        } else {
          setHasOpinion(false);
        }
      } catch (error) {
        console.error('Błąd podczas sprawdzania opinii użytkownika:', error);
      } finally {
        setLoading(false);
      }
    };

    if (isLoggedIn && userId && id) {
      checkUserOpinion();
    }
  }, [id, isLoggedIn]);

  const toggleLike = async () => {
    if (!userId) {
      navigate('/login');
      return;
    }

    try {
      if (liked) {
        await fetch(`http://localhost:5000/favourite_delete/${userId}/${id}`, { method: 'POST' });
        setLiked(false);
      } else {
        await fetch(`http://localhost:5000/favourite_add/${userId}/${id}`, { method: 'POST' });
        setLiked(true);
      }
    } catch (error) {
      console.error('Błąd przy zmianie stanu ulubionych:', error);
    }
  };

  if (isLoading) {
    return <p>Ładowanie szczegółów produktu...</p>;
  }

  if (error) {
    return <p>Błąd: {error}</p>;
  }

  const { alkohol, opinie, srednia_ocena } = productData;

  const renderRatingStars = (rating) => {
    const fullStars = "⭐".repeat(rating);
    const emptyStars = "☆".repeat(5 - rating);
    return fullStars + emptyStars;
  };

  const handleAddOpinionClick = () => {
    if (!userId) {
      navigate('/login');
      return;
    }
    setShowAddOpinion(!showAddOpinion);
  };

  const handleOpinionChange = (e) => {
    const { name, value } = e.target;
    setNewOpinion((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmitOpinion = async () => {
    if (!userId) return;

    try {
      await fetch(`http://localhost:5000/add_opinion`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          produkt_id: id,
          user_id: userId,
          ocena: newOpinion.ocena,
          recenzja: newOpinion.recenzja,
        }),
      });

      setProductData((prev) => ({
        ...prev,
        opinie: [
          ...prev.opinie,
          { ...newOpinion, znacznik_czasu: 'Teraz', uzytkownik: 'Ty' },
        ],
      }));
      setShowAddOpinion(false);
      setNewOpinion({ ocena: 0, recenzja: '' });
    } catch (error) {
      console.error('Błąd przy dodawaniu opinii:', error);
    }
  };

  const handleDeleteOpinion = async (opiniaId) => {
    try {
      const response = await fetch(`http://localhost:5000/delete_opinion/${opiniaId}/${id}`, {
        method: 'DELETE',
      });
      if (!response.ok) throw new Error('Nie udało się usunąć opinii');
      setProductData((prevData) => ({
        ...prevData,
        opinie: prevData.opinie.filter((opinia) => opinia.id !== opiniaId),
      }));
    } catch (error) {
      console.error('Błąd przy usuwaniu opinii:', error);
    }
  };

  const handleDeleteAlcohol = async () => {
    try {
      const response = await fetch(`http://localhost:5000/delete_alcohol/${id}`, {
        method: 'DELETE',
      });
      if (!response.ok) throw new Error('Nie udało się usunąć alkoholu');
      navigate('/');
    } catch (error) {
      console.error('Błąd przy usuwaniu alkoholu:', error);
    }
  };

  const handleEditClick = () => {
    setIsEditing(true);
    setEditedAlcohol({
      nazwa: alkohol.nazwa,
      rodzaj: alkohol.rodzaj,
      zawartosc_procentowa: alkohol.zawartosc_procentowa,
      rok_produkcji: alkohol.rok_produkcji,
      opis: alkohol.opis,
      image: alkohol.image_url,
    });
  };
  
  const handleSaveChanges = async () => {
    try {
      const response = await fetch(`http://localhost:5000/edit_alcohol/${id}`, {
        method: 'PUT',
        body: JSON.stringify(editedAlcohol),
        headers: {
          'Content-Type': 'application/json',
        },
      });
      if (!response.ok) throw new Error('Nie udało się zapisać zmian');
      setIsEditing(false);
      window.location.reload()
    } catch (error) {
      console.error('Błąd przy zapisywaniu zmian:', error);
    }
  };
  

  return (
    <div className="container">
      <div className="product-details">
        <div className="product-details-content">
          <img src={alkohol.image_url} alt={alkohol.nazwa} className="product-image" />
          <div className="product-info">
            <h2>{alkohol.nazwa}</h2>
            <div className="product-attributes">
              <p><strong>Średnia ocena:</strong> {srednia_ocena} / 5</p>
              <p><strong>Rodzaj:</strong> {alkohol.rodzaj}</p>
              <p><strong>Zawartość procentowa:</strong> {alkohol.zawartosc_procentowa}%</p>
              <p><strong>Rok produkcji:</strong> {alkohol.rok_produkcji}</p>
            </div>
            <p className="product-description"> {alkohol.opis}</p>
          </div>
        </div>
        
        <button
          className={`Product_like-button ${liked ? 'liked' : ''}`}
          onClick={toggleLike}
        >
          {liked ? '❤️' : '🖤'}
        </button>
  
        {isAdmin && (
          <div className="product-actions">
            <button
              className="edit-form-button"
              onClick={handleEditClick}
            >
              Edytuj alkohol
            </button>
            <button
              className="delete-alcohol-button"
              onClick={handleDeleteAlcohol}
            >
              Usuń alkohol
            </button>
          </div>
        )}
      </div>
  
      {isEditing ? (
        <div className="edit-form">
          <h3>Edytuj alkohol</h3>
          <form onSubmit={(e) => e.preventDefault()}>
              <label>Nazwa:</label>
            <div>
              <input
                type="text"
                value={editedAlcohol.nazwa}
                onChange={(e) => setEditedAlcohol({ ...editedAlcohol, nazwa: e.target.value })}
              />
            </div>
            <label>Rodzaj:</label>
            <div>
              <select
                value={editedAlcohol.rodzaj}
                onChange={(e) => setEditedAlcohol({ ...editedAlcohol, rodzaj: e.target.value })}
              >
                {alcoholTypes.map((type, index) => (
          <option key={index} value={type}>
            {type}
          </option>
        ))}
              </select>
            </div>
            <label>Zawartość procentowa:</label>
            <div>
              <input
                type="number"
                value={editedAlcohol.zawartosc_procentowa}
                onChange={(e) => setEditedAlcohol({ ...editedAlcohol, zawartosc_procentowa: e.target.value })}
              />
            </div>
            <label>Rok produkcji:</label>
            <div>
              <input
                type="number"
                value={editedAlcohol.rok_produkcji}
                onChange={(e) => setEditedAlcohol({ ...editedAlcohol, rok_produkcji: e.target.value })}
              />
            </div>
            <label>Opis:</label>
            <div>
              <textarea
                value={editedAlcohol.opis}
                onChange={(e) => setEditedAlcohol({ ...editedAlcohol, opis: e.target.value })}
              />
            </div>
            <div className="form-buttons">
              <button type="button" onClick={handleSaveChanges}>Zapisz zmiany</button>
              <button type="button" onClick={() => setIsEditing(false)}>Anuluj</button>
            </div>
          </form>
        </div>
      ) : null}
  
      <div className="opinions">
        <div className="opinions-header">
          <h2>Opinie:</h2>
          {isLoggedIn && !loading && (
            hasOpinion ? (
              <p>Już wystawiłeś opinię dla tego produktu. Jeśli chcesz edytować <Link to="/profile">przejdź do profilu. </Link></p>
            ) : (
              <button className="add-opinion-button" onClick={handleAddOpinionClick}>
                {showAddOpinion ? 'Anuluj' : 'Dodaj opinię'}
              </button>
            )
          )}
        </div>

        {showAddOpinion && (
          <div className="opinion-form">
            <div className="rating-stars">
              {[1, 2, 3, 4, 5].map((star) => (
                <span
                  key={star}
                  className={`star ${newOpinion.ocena >= star ? 'filled' : ''}`}
                  onMouseEnter={() => setHoverRating(star)}
                  onMouseLeave={() => setHoverRating(null)}
                  onClick={() => setNewOpinion({ ...newOpinion, ocena: star })}
                >
                  {hoverRating >= star || newOpinion.ocena >= star ? '⭐' : '☆'}
                </span>
              ))}
            </div>
            <textarea
              name="recenzja"
              value={newOpinion.recenzja}
              onChange={handleOpinionChange}
              placeholder="Napisz swoją opinię..."
            />
            <button onClick={handleSubmitOpinion}>Zatwierdź opinię</button>
          </div>
        )}

        {opinie.length > 0 ? (
          <ul>
            {opinie.map((opinia, index) => (
              <li key={index} className="opinion-item">
                <div className="opinion-header">
                  <span className="opinion-user">{opinia.uzytkownik}</span>
                  {isAdmin && (
                    <button
                      className="delete-opinion-button"
                      onClick={() => handleDeleteOpinion(opinia.id)}
                    >
                      Usuń
                    </button>
                  )}
                </div>
                <p><strong>Data:</strong> {opinia.znacznik_czasu}</p>
                <div>
                  <strong>Ocena:</strong> {renderRatingStars(opinia.ocena)}
                </div>
                <p><strong>Recenzja:</strong> {opinia.recenzja || 'Brak recenzji'}</p>
              </li>
            ))}
          </ul>
        ) : (
          <p>Brak opinii.</p>
        )}
      </div>
    </div>
  );  
};

export default ProductDetail;
