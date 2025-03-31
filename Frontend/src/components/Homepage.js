import React, { useState, useEffect } from 'react';
import Cookies from 'js-cookie';
import ProductList from './subcomponents/ProductList';
import FilterPanel from './subcomponents/FilterPanel';
import AddProductModal from './subcomponents/AddProductPanel';
import '../styles/Homepage.css';
import '../styles/styles.css';

const role = Cookies.get("role");

const Homepage = () => {
  const [products, setProducts] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const [selectedCategories, setSelectedCategories] = useState([]);
  const [visibleProducts, setVisibleProducts] = useState(18);
  const [categories, setCategories] = useState([]);
  const [isAddOpen, setIsAddOpen] = useState(false);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const query = selectedCategories.length
          ? `http://localhost:5000/getProducts?categories=${selectedCategories.join(',')}`
          : 'http://localhost:5000/getProducts';
        const response = await fetch(query);
        if (!response.ok) {
          throw new Error('Failed to fetch products');
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
  }, [selectedCategories]);

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
    <div className="homepage-container">
      <FilterPanel 
        categories={categories} 
        selectedCategories={selectedCategories} 
        setSelectedCategories={setSelectedCategories}
        setIsAddOpen={setIsAddOpen}
        role={role}
      />

      <ProductList 
        products={products} 
        visibleProducts={visibleProducts} 
        loadMoreProducts={loadMoreProducts} 
      />

      {isAddOpen && <AddProductModal closeModal={() => setIsAddOpen(false)} categories={categories} />}
    </div>
  );
};

export default Homepage;
