function     decode(data,nbpp,retv){
        nbpp*= 8;
        tmp0 = data.replace(/.{2}/g,'$&,').split(',').map(x=>parseInt(x,16));
        tmp0.pop();
        tmp0 = tmp0.map(x=>x.toString(2).padStart(8,0)).join('').replace(new RegExp('.{'+nbpp+'}','g'),'$&,').split(',');
        tmp0.pop();
        tmp1 = '';
for(k in Array(tmp0   .length  ).fill()){
for(j in Array(               8).fill()){
        tmp2 ='';
for(i in Array(tmp0[k].length/8).fill()){
        tmp2+= tmp0[k][nbpp-8-i*8+j*1];
}       tmp1+= parseInt(tmp2,2).toString(16);
}}      tmp1 = tmp1.replace(new RegExp('.{'+(retv)+'}','g'),'$&,').split(',');
        tmp1.pop();
        tmp1 = tmp1.join('\n');
return  tmp1;
}
