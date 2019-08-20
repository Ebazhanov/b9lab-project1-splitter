import React, {Component} from 'react'
import * as services from './config/contract-services'
import getWeb3 from './utils/getWeb3'

import './css/oswald.css'
import './css/open-sans.css'
import './css/pure-min.css'
import './App.css'

var contractInstance;
var userList;
var web3Instance;

class App extends Component {
  constructor(props) {
    super(props)

    this.state = {
      storageValue: 0,
      web3: null
    }
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);

  }


  async componentWillMount() {

    web3Instance = await  services.initWeb3();
    contractInstance = await  services.getContract(web3Instance);
    userList = await  services.getAccounts(web3Instance);
    this.updateBalance();
    await this.getAccounts();
  }

  async getAccounts() {
    console.log(userList)
    var firstAcc = await  this.getFirstAcc();
    var secAcc = await  this.getSecAcc();
    var thirdAcc = await  this.getThirdAcc();
    this.setState({
      firstAcc: firstAcc,
      secondAcc: secAcc,
      thirdAcc: thirdAcc
    })


  }


  async updateBalance() {
    console.log(contractInstance)
    this.setState({storageValue: await services.getContractBalance(web3Instance, contractInstance)});
  }

  async handleSubmit(event) {
    event.preventDefault();
    await  services.payFunct(contractInstance, this.state.value, userList[0]);
    this.updateBalance();
  }

  handleChange(event) {
    this.setState({value: event.target.value});
  }

  splitMoney() {
    services.splitFunct(contractInstance, userList[0]);
    this.updateBalance();
  }

  async getFirstAcc() {
    console.log("get")
    var res = await  services.getFirstAddr(contractInstance);
    console.log(res)
    return res;
  }

  async getSecAcc() {
    let res = await  services.getSecAcc(contractInstance);
    return res;
  }

  async getThirdAcc() {
    let res = await  services.getThirdAcc(contractInstance);
    return res;
  }


  async getFirstAccBalance() {

    var res = await  services.getFirstAddrBal(contractInstance, web3Instance);
    alert("First Account balance is: " + res)
  }

  async getSecAccBalance() {
    var res = await  services.getSecondAddrBal(contractInstance, web3Instance);
    alert("Second Account balance is: " + res)

  }

  async getThirdAccBalance() {
    var res = await  services.getThirdAddrBal(contractInstance, web3Instance);
    alert("Third Account balance is:  " + res)

  }

  async destroy() {
    await  services.destroyContract(contractInstance, userList[0]);
  }

  render() {


    return (
      <div className="App">


        <main className="container">
          <div className="pure-g">
            <div className="pure-u-1-1">
              <h1>Splitter application</h1>
              <form onSubmit={this.handleSubmit}>
                <label>
                  Send money to contract:
                  <input type="number" value={this.state.value} onChange={this.handleChange}/>
                </label>
                <input type="submit" value="Submit"/>

              </form>
              <button onClick={this.splitMoney.bind(this)}>Split Money</button>
              <br/>

              <button onClick={this.getFirstAccBalance.bind(this)}>Get Alice Balance</button>
              <button onClick={this.getSecAccBalance.bind(this)}>Get Bob Balance</button>
              <button onClick={this.getThirdAccBalance.bind(this)}>Get Carol Balance</button>
              <br/>
              <button onClick={this.destroy.bind(this)}>Destroy Contract</button>

              <h2>Current contract balance is: {this.state.storageValue}</h2>

            </div>
          </div>
        </main>
      </div>
    );
  }
}

export default App
