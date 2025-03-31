import React, { useState, useEffect } from 'react';
import axios from 'axios';
import Cookies from 'js-cookie'; 
import { useNavigate } from 'react-router-dom';
import '../styles/History.css';
import '../styles/styles.css';

const Achievements = () => {
    const [achievements, setAchievements] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    useEffect(() => {
        const userId = Cookies.get('user_id');

        if (!userId) {
            navigate('/login');
            return;
        }

        const fetchAchievements = async () => {
            try {
                const response = await axios.get('http://localhost:5000/osiagniecia');
                setAchievements(response.data);
                setLoading(false); 
            } catch (error) {
                console.error('Błąd podczas pobierania danych o osiągnięciach', error);
                setLoading(false); 
            }
        };

        fetchAchievements(); 
    }, [navigate]);

    if (loading) {
        return <div>Ładowanie...</div>; 
    }

    return (
        <div className="History">
            <h1>Osiągnięcia</h1>
            <div className="History-list">
                {achievements.map((achievement) => (
                    <div key={achievement.id_osiagniecia} className="History-card">
                        <img 
                            src={achievement.image_url || 'https://img.freepik.com/darmowe-wektory/trofeum_78370-345.jpg'}
                            alt={achievement.nazwa_osiagniecia} 
                            className="History-image" 
                        />
                        <div className="History-info">
                            <h2>{achievement.nazwa_osiagniecia}</h2>
                            <p>{achievement.opis_osiagniecia}</p>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default Achievements;
