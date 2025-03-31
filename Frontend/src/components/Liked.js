import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import Cookies from 'js-cookie';
import ProductList from './subcomponents/ProductList';
import FilterPanel from './subcomponents/FilterPanel';
import '../styles/Homepage.css';
import '../styles/styles.css';
import '../styles/Liked.css';

const userId = Cookies.get('user_id');

const Liked = () => {
  const [products, setProducts] = useState([]);
  const [visibleProducts, setVisibleProducts] = useState(18);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const [selectedCategories, setSelectedCategories] = useState([]); 
  const [categories, setCategories] = useState([]);
  const navigate = useNavigate();

  useEffect(() => {
    if (!userId) {
      navigate('/login');
      return;
    }

    const fetchProducts = async () => {
      try {
        const query = selectedCategories.length
          ? `http://localhost:5000/ulubione/${userId}?categories=${selectedCategories.join(',')}`
          : `http://localhost:5000/ulubione/${userId}`;

        const response = await fetch(query);
        if (!response.ok) {
          throw new Error('Failed to fetch favorite products');
        }

        const data = await response.json();
        setProducts(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setIsLoading(false);
      }
    };

    fetchProducts();
  }, [selectedCategories, navigate]);

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const response = await fetch('http://localhost:5000/alcohol_types');
        if (!response.ok) {
          throw new Error('Failed to fetch categories');
        }

        const data = await response.json();
        setCategories(data);
      } catch (err) {
        setError(err.message);
      }
    };

    fetchCategories();
  }, []);

  const loadMoreProducts = () => {
    setVisibleProducts(prevVisible => prevVisible + 20);
  };

  if (isLoading) {
    return <p>Loading products...</p>;
  }

  if (error) {
    return <p>Error: {error}</p>;
  }

  return (
    <div className="liked-container">
      <div className="favorites-header">
        <h1>Posmakowane</h1>
      </div>
      <FilterPanel 
        categories={categories} 
        selectedCategories={selectedCategories} 
        setSelectedCategories={setSelectedCategories}
      />

      <ProductList 
        products={products} 
        visibleProducts={visibleProducts} 
        loadMoreProducts={loadMoreProducts} 
      />

    </div>
  );
};

export default Liked;
