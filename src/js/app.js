App = {
      web3Provider: null,
      contracts: {},
      account: 0x0,
      owner: 0x0,

      init: function () {
            return App.initWeb3();
      },

      initWeb3: function () {
            // initialize web3
            if (typeof web3 !== 'undefined') {
                  //reuse the provider of the Web3 object injected by Metamask
                  App.web3Provider = web3.currentProvider;
            } else {
                  //create a new provider and plug it directly into our local node
                  App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
            }
            web3 = new Web3(App.web3Provider);
            App.owner = web3.eth.accounts[0];
            App.account = web3.eth.accounts[1];
            //   App.displayAccountInfo();

            web3.eth.getAccounts(function (err, accounts) {
                  if (err != null) console.error("An error occurred: " + err);
                  else if (accounts.length == 0) console.log("User is not logged in to MetaMask");
                  else {
                        console.log("User is logged in to MetaMask " + accounts);
                  }
            });
            return App.initContract();
      },

      loginUser: function () {
            event.preventDefault();
            var _email = $('#email').val();
            var _pass = $('#password').val();
            App.contracts.FitSwap.deployed().then(function (instance) {
                  return instance.login(_email, _pass, {
                        from: App.account,
                        gas: 500000
                  });
            }).then(function (result) {
                  if (result[0].length == 0) {
                        alert("you have not registered yet, Please signup and come back!!");
                        window.location.href = '/templates/register.html';
                  }
                  else {
                        if (result[2] != _email || result[4] != _pass) {
                              alert("Invlaid user name or password!!");
                              window.location.reload(false);
                        }
                        else {
                              alert("login success!!");
                              if (typeof (Storage) !== "undefined") {
                                    localStorage.setItem("fname", result[0]);
                                    localStorage.setItem("lname", result[1]);
                                    localStorage.setItem("email", result[2]);
                                    localStorage.setItem("account", App.account);
                                    web3.eth.getBalance(App.account, function (err, balance) {
                                          if (err === null) {
                                                localStorage.setItem("balance", web3.fromWei(balance, "ether"));
                                          }

                                    })
                              }
                        }

                  }

            }).catch(function (err) {
                  alert("not registered")
                  console.error(err);
            });

      },

      addCustomer: function(){
            _address = 'get the address';
            App.contracts.Customer.deployed().then(function(app){
                  return app.addCustomer(address,{
                        from: App.account,
                        gas: 500000  
                  });
            }).then(function(result){
                  if(!result || result[0] == 0){
                        console.log("error")
                        alert("Please add the service again");
                  }else{
                        alert("service added successfully");
                  }
            });

      },

      registerUsers:function(){
            App.contracts.FitSwap.deployed().then(function(app){
                  return app.register(_fname, _lname, _email, _pass, _type, _skill, {
                        from: App.account,
                        gas: 500000  
                  });
            }).then(function(result){
                  if(!result || result[0] == 0){
                        console.log("error")
                        alert("Please register again");
                  }else{
                        alert("registration successful")
                        getServices();
                  }
            })
      },


     

     
           getUserByAddress:function(add, callback){
                       App.contracts.Insurance.deployed().then(function (instance) {
                             return instance.get_user_by_address(add, {
                                   from: App.account,
                                   gas: 500000
                             });
                       }).then(function (result) {
                             callback(result)
                       }).catch(function (err) {
                             console.error(err);
                       });
                 },

                
            createWakeUp: function(){
                  var alarm = $('#hours').val();
                  App.contracts.WakeUp.deployed().then(function(app){
                        return app.setAlarm(hours, {
                              from: App.owner,
                              value: 10,
                              gas: 500000  
                        });
                  }).then(function (result) {
                        console.log(result)
                  }).catch(function (err) {
                        console.error(err);
                  });
                 },

            enterPassword: function(){
                  App.contracts.WakeUp.deployed().then(function(app){
                        return app.setPassword(pass, {
                              from: App.owner,
                              gas: 500000  
                        });
                  }).then(function (result) {
                        console.log(result)
                  }).catch(function (err) {
                        console.error(err);
                  });
                 },

            wakeUp: function(){
                  App.contracts.WakeUp.deployed().then(function(app){
                        return app.enterPassword(pass, {
                              from: App.owner,
                              gas: 500000  
                        });
                  }).then(function (result) {
                        console.log(result)
                  }).catch(function (err) {
                        console.error(err);
                  });
                 },





      initContract: function () {
            initFitSwap();
      },

      initFitSwap:function(){
            $.getJSON('../UserEscrow.json', function (escrow) {
                  App.contracts.UserEscrow = TruffleContract(escrow);
                  App.contracts.UserEscrow.setProvider(App.web3Provider);
            });
            $.getJSON('../Customer.json', function (customer) {
                  App.contracts.Customer = TruffleContract(customer);
                  App.contracts.Customer.setProvider(App.web3Provider);
            });
            $.getJSON('../WeightPool.json', function (weight) {
                  App.contracts.WeightPool = TruffleContract(weight);
                  App.contracts.WeightPool.setProvider(App.web3Provider);
            });
            $.getJSON('../WakeUp.json', function (wakeup) {
                  App.contracts.WakeUp = TruffleContract(wakeup);
                  App.contracts.WakeUp.setProvider(App.web3Provider);
            });
            $.getJSON('../FitSwap.json', function (fitswap) {
                  App.contracts.FitSwap = TruffleContract(fitswap);
                  App.contracts.FitSwap.setProvider(App.web3Provider);
            });
            
      },


            
      getFitSwap: function () {
            return App.contracts.FitSwap;
      },
      getCustomer: function () {
            return App.contracts.Customer;
      },
      getUserEscrow: function () {
            return App.contracts.Insurance;
      },
      getWakeUp: function () {
            return App.contracts.WakeUp;
      },
      getWeightPool: function () {
            return App.contracts.WeightPool;
      }


};

$(function () {
      $(window).load(function () {
            App.init();
      });
});

