const path = require('path');
const fs = require('fs');
const solc = require('solc'); 

const CONTRACT = 'multi-approval-transfer.sol';

const sourcePath = path.resolve(__dirname,'contracts', CONTRACT);

const source = fs.readFileSync(sourcePath,'utf8');

console.log(solc.compile(source,1));