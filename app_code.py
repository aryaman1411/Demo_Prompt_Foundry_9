Here is a basic starter code for an online shopping application using Node.js and Express.js. This code includes basic functionality such as product listing and adding products to a cart.

```javascript
const express = require('express');
const app = express();

let products = [
    { id: 1, name: 'Product 1', price: 100 },
    { id: 2, name: 'Product 2', price: 200 },
    { id: 3, name: 'Product 3', price: 300 },
];

let cart = [];

app.get('/products', (req, res) => {
    res.json(products);
});

app.get('/cart', (req, res) => {
    res.json(cart);
});

app.post('/cart/:productId', (req, res) => {
    let productId = req.params.productId;
    let product = products.find(p => p.id == productId);

    if (!product) {
        res.status(404).send('Product not found');
    } else {
        cart.push(product);
        res.json(cart);
    }
});

app.listen(3000, () => console.log('Server is running on port 3000'));
```

To deploy this code to GitHub, follow these steps:

1. Initialize a new repository on your local machine with `git init`.
2. Add all the files to the repository with `git add .`.
3. Commit the changes with `git commit -m "Initial commit"`.
4. Create a new repository on GitHub.
5. Link the local repository to the GitHub repository with `git remote add origin <your-github-repo-url>`.
6. Push the changes to the GitHub repository with `git push -u origin master`.

Please note that this is a very basic implementation and does not include any form of user authentication, error handling, or persistence. These features would need to be added for a production-ready application. Also, the Azure resources mentioned would need to be set up separately and integrated with this application.