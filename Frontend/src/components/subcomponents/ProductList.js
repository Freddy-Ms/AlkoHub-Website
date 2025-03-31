import React from 'react';
import { Link } from 'react-router-dom';
import ProductCard from './ProductCard';

const ProductList = ({ products, visibleProducts, loadMoreProducts }) => {
    return (
        <div className="product-container">
            <div className="product-list">
                {products.slice(0, visibleProducts).map((product, index) => (
                <Link key={index} to={`/product/${product.id}`} className="product-link">
                    <ProductCard product={product} />
                </Link>
                ))}
            </div>
            {visibleProducts < products.length && (
                <button className="load-more-btn" onClick={loadMoreProducts}>
                Pokaż więcej
                </button>
            )}
        </div>
    );
};

export default ProductList;