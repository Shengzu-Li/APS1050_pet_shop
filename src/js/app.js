App = {
  web3Provider: null,
  contracts: {},

  init: async function() {
    // Load pets.
    $.getJSON('../pets.json', function(data) {
      var petsRow = $('#petsRow');
      var petTemplate = $('#petTemplate');

      for (i = 0; i < data.length; i ++) {
        petTemplate.find('.panel-title').text(data[i].name);
        petTemplate.find('img').attr('src', data[i].picture);
        petTemplate.find('.pet-breed').text(data[i].breed);
        petTemplate.find('.pet-age').text(data[i].age);
        petTemplate.find('.pet-location').text(data[i].location);
        petTemplate.find('.btn-adopt').attr('data-id', data[i].id);

        petsRow.append(petTemplate.html());
      }
    });

    return await App.initWeb3();
  },

  initWeb3: async function() {

    // Modern dapp browsers...
if (window.ethereum) {
  App.web3Provider = window.ethereum;
  try {
    // Request account access
    await window.ethereum.enable();
  } catch (error) {
    // User denied account access...
    console.error("User denied account access")
  }
}
// Legacy dapp browsers...
else if (window.web3) {
  App.web3Provider = window.web3.currentProvider;
}
// If no injected web3 instance is detected, fall back to Ganache
else {
  App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
}
web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function() {
    $.getJSON('Adoption.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      var AdoptionArtifact = data;
      App.contracts.Adoption = TruffleContract(AdoptionArtifact);
    
      // Set the provider for our contract
      App.contracts.Adoption.setProvider(App.web3Provider);
    
      // Use our contract to retrieve and mark the adopted pets
      return App.markAdopted();
    });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-adopt', App.handleAdopt);
    $(document).on('click', '.btn-register', App.handleRegister);
  },

  markAdopted: function(adopters, account) {
    var adoptionInstance;

    App.contracts.Adoption.deployed().then(function(instance) {
      adoptionInstance = instance;
    
      return adoptionInstance.getAdopters.call();
    }).then(function(adopters) {
      for (i = 0; i < adopters.length; i++) {
        if (adopters[i] !== '0x0000000000000000000000000000000000000000') {
          $('.panel-pet').eq(i).find('button').text('Success').attr('disabled', true);
        }
      }
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  handleAdopt: function(event) {
    event.preventDefault();

    var petId = parseInt($(event.target).data('id'));

    var adoptionInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }
    
      var account = accounts[0];
    
      App.contracts.Adoption.deployed().then(function(instance) {
        adoptionInstance = instance;
    
        // Execute adopt as a transaction by sending account
        return adoptionInstance.adopt(petId, {from: account});
      }).then(function(result) {
        return App.markAdopted();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },

  handleRegister: function(event) {
    event.preventDefault();
    
    const fileInput = $('<input type="file" id="imageInput" style="display: none;">');
    $('.registerForm').append(fileInput);
    fileInput.click();
    
    fileInput.on('change', function(event) {
      const selectedImg = event.target.files[0];

      if (!selectedImg.type.startsWith('image/')) {
        alert("File uploaded is not an image! Please try again!")
      }else{
        const reader = new FileReader();

        reader.onload = (e) => {
          var imgContent = e.target.result;

          $.getJSON('../pets.json', function(data) {

            var name = prompt("Waht's the pet's name?", "Dabao");
            var breed = prompt("What's the pet's breed?", "Tugou")
            var age = parseInt(prompt("What's the pet's age?", "3"))
            var location = prompt("What's the pet's location?", "Toronto, Ontario")
            var lastId = data[data.length-1].id + 1;

            var adoptionInstance;

            web3.eth.getAccounts(function(error, accounts) {
              if (error) {
                console.log(error);
              }
    
              var account = accounts[0];
    
              App.contracts.Adoption.deployed().then(function(instance) {
                adoptionInstance = instance;

                return adoptionInstance.register(name, breed, age, location, lastId, {from: account});
              }).then(function(result) {
                var petsRow = $('#petsRow');
                var petTemplate = $('#petTemplate');

                petTemplate.find('.panel-title').text(name);
                petTemplate.find('img').attr('src', imgContent);
                petTemplate.find('.pet-breed').text(breed);
                petTemplate.find('.pet-age').text(age);
                petTemplate.find('.pet-location').text(location);
                petTemplate.find('.btn-adopt').attr('data-id', lastId);

                petsRow.append(petTemplate.html());
                
                alert("New pet add successfully!")
              }).catch(function(err) {
                console.log(err.message);
              });
            });
          });

        };

        reader.readAsDataURL(selectedImg);
      }

      $(this).remove();
    });

  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
