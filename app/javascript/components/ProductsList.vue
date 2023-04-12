<template>
    <div>
      <h1>Lista de productos</h1>
      <table>
        <thead>
          <tr>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Precio</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="product in products" :key="product.id">
            <td>{{ product.name }}</td>
            <td>{{ product.description }}</td>
            <td>{{ product.price }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        products: [],
        newProduct: {
          title: '',
          description: '',
          price: 0.0
        }
      };
    },
    mounted() {
      this.getProducts();
    },
    methods: {
      getProducts() {
        fetch("/api/v1/products")
          .then(response => response.json())
          .then(data => (this.products = data))
          .catch(error => console.log(error));
      }
    },
    postProduct() {
        fetch('/api/v1/products', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(this.newProduct)
        })
        .then(response => response.json())
        .then(data => {
          this.products.push(data);
          this.newProduct = { title: '', description: '', price: 0.0 };
        })
        .catch(error => console.log(error));
      }
  };
  </script>