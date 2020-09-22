import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter, Route, Switch, Redirect} from 'react-router-dom'
import Home from './Home';
import Header from './Header'
import AddVoter from './AddVoter';
import Results from "./Results";
import ContestantDetails from './ContestantDetails';
import Web3 from 'web3';
import base_contract from "./contracts/base_contract.json"

const web3=new Web3(Web3.givenProvider)
console.log(web3);
web3.setProvider("http://127.0.0.1:9545")
const contract=new web3.eth.Contract(base_contract.abi,"0x691E00CC42A2AAE4e96eD035976d1806D68bb08D")



ReactDOM.render(
  <BrowserRouter>
  <Header />
  <Switch>
  <Route path="/addContestants" component={()=><AddVoter web3={web3 && web3} contract={contract&&contract} />}/>
  <Route path="/results" component={Results} />
  <Route path="/contestantDetails" component={ContestantDetails} />
  <Route path="/home" component={Home}/>
  <Redirect to="/home" />
  </Switch>
  </BrowserRouter>,document.getElementById('root')
)
