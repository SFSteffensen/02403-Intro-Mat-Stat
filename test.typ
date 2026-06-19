#import "@preview/physica:0.9.8": *  
/// Integral integrate(f(x); x; 0,1)
#let integrate(func, args, bounds) = {
  let idx = 0 
  
  for arg in args {
    let lower = bounds.at(idx)
    let upper = bounds.at(idx+1)
    
 $integral_(#lower)^#upper $ 
   idx = idx + 2
 } 

 $#func.at(0) space.sixth$
   
 for arg in args {
   $upright(d) #arg space.hair$
 }
}



$
  abs(lambda_1)
$