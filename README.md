# Pet Shop Truffle Box

This box has all you need to get started with our [Pet Shop tutorial](http://truffleframework.com/tutorials/pet-shop).

## version recommend for installation
```
Node.js version: >"16.17.0"
lite-server version: "2.3.0"
Solidity version: "0.5.0"
web3 version: "4.3.0"
Truffle version: "5.11.5"
Ganache version: "7.9.1"
Front-End Framework: JQuery
```
## Installation

1. Install Truffle globally.
    ```javascript
    npm install -g truffle
    ```

2. Download the box. This also takes care of installing the necessary dependencies.
    ```javascript
    truffle unbox pet-shop
    ```

3. Run the development console.
    ```javascript
    truffle develop
    ```

4. Compile and migrate the smart contracts. Note inside the development console we don't preface commands with `truffle`.
    ```javascript
    compile
    migrate --reset
    
    ```

5. Run the `liteserver` development server (outside the development console) for front-end hot reloading. Smart contract changes must be manually recompiled and migrated.
    ```javascript
    // Serves the front-end on http://localhost:3000
    npm run dev
    ```

**NOTE**: This box is not a complete dapp, but the starting point for the [Pet Shop tutorial](http://truffleframework.com/tutorials/pet-shop). You'll need to complete that for this to function.

## FAQ

* __How do I use this with the EthereumJS TestRPC?__

    It's as easy as modifying the config file! [Check out our documentation on adding network configurations](http://truffleframework.com/docs/advanced/configuration#networks). Depending on the port you're using, you'll also need to update line 16 of `src/js/app.js`.
