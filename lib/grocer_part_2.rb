require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  coupons.each {|e|
    price = e[:cost] / e[:num]
    index_of_item = 0
    cart.each_with_index {|item, i| 
      if item[:item] == e[:item] && item[:count] >= e[:num]
        cart[i][:count] -= e[:num]
        cart.append({:item => "#{e[:item]} W/COUPON", :price => price, :clearance => item[:clearance], :count => e[:num]})
        break
      end
    }
  }
  return cart
end

def apply_clearance(cart)
  cart.each {|e| 
    if e[:clearance]
      e[:price] = e[:price] - (e[:price] * 0.2)
    end
  }
  return cart
end

def checkout(cart, coupons)
  coupons_applied = []
  final_cart = []
  consoled_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consoled_cart, coupons)
  final_cart = apply_clearance(coupons_applied)
  total = 0
  final_cart.each {|item| 
    total += item[:price] * item[:count]
  }
  total -= total * 0.10 if total > 100
  return total
end

p checkout([
  { :item => "CANNED BEANS", :price => 3.00, :clearance => true },
  { :item => "CANNED CORN", :price => 2.50, :clearance => false },
  { :item => "SALSA", :price => 1.50, :clearance => false },
  { :item => "TORTILLAS", :price => 2.00, :clearance => false },
  { :item => "HOT SAUCE", :price => 1.75, :clearance => false },
  {:item => "AVOCADO", :price => 3.00, :clearance => true},
], [
  {:item => "AVOCADO", :num => 2, :cost => 5.00}
])
