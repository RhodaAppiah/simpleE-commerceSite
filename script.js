



//var addCart = document.getElementById("butt")
//var count = 0 
//
//function updateCart(){
//
// //count = count + 1
// //console.log(count)
//}


let costItems = '{"assorted-coffee":"150.00","pack of juice":"300.00","red chilles":"30.00","sanitizer":"42.00","lemon":"46.50","lettuce":"5.00","scoop of legumes":"4.50","oil":"25.00","bell pepppers":"24.00"}'
let data = JSON.parse(costItems)
let var1 = data["assorted-coffee"]
console.log(var1)
document.getElementById("price-no").innerHTML = var1


var count1 = 0 

function updateBox(){
 count1 = count1 + 1
var boxUpdate = document.getElementById("button-update").innerText = count1
console.log(count1)
var addCart = document.getElementById("cart").innerHTML =  count1.valueOf() * var1

}

var review = document.getElementById("tab-2")
var description = document.getElementById("tab-1")
//review.addEventListener("click",()=>{   
//document.getElementById("second-tab").style.display = "visible"
//document.getElementById("first-tab").style.display = "hidden"
//})
//
//description.addEventListener("click",()=>{
//    document.getElementById("first-tab").style.display = "visible"
//    document.getElementById("second-tab").style.display = "hidden"
//})

review.addEventListener("click",()=>{   
    document.getElementById("second-tab").style.display = "block"
    document.getElementById("first-tab").style.display = "none"
    })
    
    description.addEventListener("click",()=>{
    document.getElementById("first-tab").style.display = "block"
    document.getElementById("second-tab").style.display = "none"
    })
    

//const hover = document.getElementById("fit")//

//for ()
 //var icos =  document.getElementById("fit").addEventListener("mouseover",function(e){
    //e.target.style="none"
    
    var icons = document.querySelectorAll(".fit")
    icons.forEach(icon => {
       icon.addEventListener('mouseover',function(){
           //alert('mouse entered')
           //icon.classList.remove('fit')
           if (icon.id ==="wat"){
              icon.classList.add("wat")
           }
           if (icon.id ==="ig"){
              icon.classList.add("ig")
           }
           if (icon.id ==="twit"){
              icon.classList.add("twit")
           }
           if (icon.id ==="git"){
              icon.classList.add("git")
           }
           if (icon.id ==="ytb"){
              icon.classList.add("ytb")
           }
       })
    });
  
    //leaves
    icons.forEach(icon => {
      icon.addEventListener('mouseout',function(){
          //alert('mouse entered')
          //icon.classList.remove('fit')
          if (icon.id ==="wat"){
             icon.classList.remove("wat")
          }
          if (icon.id ==="ig"){
             icon.classList.remove("ig")
          }
          if (icon.id ==="twit"){
             icon.classList.remove("twit")
          }
          if (icon.id ==="git"){
             icon.classList.remove("git")
          }
          if (icon.id ==="ytb"){
             icon.classList.remove("ytb")
          }
      })
   });
  
   var lines = document.querySelectorAll("#line")
   lines.forEach(lin=>{
     lin.addEventListener('mouseover',function(){
        if (lin.id ==="line"){
           
        }
     })
   })


  //})
  // var ytb = document.getElementById('ytb')
  // ytb.onmouseover=function(){
  //     ytb.style.color = '#d90222'
  //     ytb.style.backgroundColor= 'white'
  //     ytb.style.borderRadius='12px'
  //     ytb.style.border='1px solid black'
  //     ytb.style.border='none'
  //     ytb.style.outline='none';
  // } 


    