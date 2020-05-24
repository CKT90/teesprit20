function update_sales() {

        function getSum(total, num) {
            return total + num;
        }

        var total = [];
        $("[id^=revenue_number]").each(function(){
            var add = parseFloat($(this).html().replace(/,/g, ''));
            total.push(parseFloat(add));

        });
        console.log(total);
        
        document.getElementById("revenue_amount").innerHTML = commaSeparateNumber(total.reduce(getSum).toFixed(2));


        var actual_total = [];
        $("[id^=actual_number]").each(function(){
            var add = parseFloat($(this).html().replace(/,/g, ''));
            actual_total.push(parseFloat(add));
        });
        document.getElementById("actual_amount").innerHTML = commaSeparateNumber(actual_total.reduce(getSum).toFixed(2));


        var delivery_total = [];
        $("[id^=delivery_number]").each(function(){
            var add = parseFloat($(this).html().replace(/,/g, ''));
            delivery_total.push(parseFloat(add));
        });
        document.getElementById("delivery_amount").innerHTML = commaSeparateNumber(delivery_total.reduce(getSum).toFixed(2));


        var net_total = [];
        $("[id^=net_number]").each(function(){
            var add = parseFloat($(this).html().replace(/,/g, ''));
            net_total.push(parseFloat(add));
        });
        document.getElementById("net_amount").innerHTML = commaSeparateNumber(net_total.reduce(getSum).toFixed(2));

}

  function commaSeparateNumber(val){
    while (/(\d+)(\d{3})/.test(val.toString())){
      val = val.toString().replace(/(\d+)(\d{3})/, '$1'+','+'$2');
    }
    return val;
  }