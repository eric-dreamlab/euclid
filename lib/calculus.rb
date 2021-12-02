def bisection_method(func, interval_start, interval_end, verbose=true)

    def opposite_signs?(num1, num2)
      return num1 * num2 < 0.0
    end
  
    raise "interval start should less than interval end" unless interval_start < interval_end
    
    midpoint = (interval_start + interval_end) / 2.0
    f_1 = func.call(interval_start)
    f_2 = func.call(interval_end)
    f_m = func.call(midpoint)
    raise "Do not have a solution" unless opposite_signs?(f_1, f_2)
    
    return midpoint if f_m.abs < 0.0001
      
    puts "#{interval_start}, #{midpoint}, #{interval_end}, #{f_m}" if verbose
    
    if opposite_signs?(f_1, f_m)
      bisection_method(func, interval_start, midpoint)
    else
      bisection_method(func, midpoint, interval_end)
    end
    
  end
  
  
  #my_func = -> (x) { x ** 3 - x - 1}
  # my_func = ->(x) {Math.sin(x) + 1 - x ** 2}
  
  my_func = ->(x) {x ** 4 - x - 1}
  
  
  puts bisection_method(my_func, 1, 2)
  puts bisection_method(my_func, -1, 0)