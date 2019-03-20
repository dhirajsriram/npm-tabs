# NPM-Tabs

An autocompletion shell script that autocoplete the commands based on the scripts declared in the package.json file.

## Requirement

- Jq
- Terminal that runs shell script (Support for windows under development)

## Installation
- Place the 
npm install 
```

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. 

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Description

The application works on two tabs which can be found at the head of the web app.
- Search
- Branches

### Search component

Used to search for a branch corresponding to the city. Kindly type into the search feild to begin. The search feild also has autocomplete enabled to help the user to look for a specific city name. Once the user has typed into the field the seach button gets enabled which when clicked, displays a list of branches specific to the city name.

**Following is a code snippet related to the functionality**
```js
searchByCity(){
    let results = this.brandData.Branch.filter(a=>a.PostalAddress.TownName == this.city.toUpperCase())
    this.searchTerm = this.city;
    this.searchResults = results;
  }
```

**Autocomplete for Search bar - Produces a list of unique city names**
```js
private getCityNames(){
    if(this.branchData){
    for(let bank in this.branchData.data){
      for(let brand in this.branchData.data[bank].Brand){
        this.brandData = this.branchData.data[bank].Brand[brand]
        let result = this.brandData.Branch.map(a => a.PostalAddress.TownName);
        let bankaddress = [...result];
        this.bankAddress= Array.from(new Set(bankaddress));
        }
      }
    }
}
```

### Branch list component

Used to display a list of all the branches of a brand. The app first fetches the branch list as follows

### app.component.ts
```js
getBranches(){
    this.BankService.branches(this.branches).subscribe(data=>{
      this.branchData = data;
    })
  }
 ```
### bank.service.ts
```js
branches(branches: string): Observable<any> {
    return this.http.get(this.baseurl + branches);
  }
```
The data that has been subscribed to is then passed onto the branch-list component which is then being retained locally. The list is then iterated through and every single branch element in the list is a seperate Branch component.

**Kindly refer this image for the architecture**

![alt text](/Aavri-bank.png)

