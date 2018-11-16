$(document).ready(function(){
    $("#add").click(function(e){
        console.log(e)
        $(".items").append('List Item(s): <input type="text" name="list[list_item][]">');
    });
});