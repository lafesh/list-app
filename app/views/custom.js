$(document).ready(function(){

    $("#add").click(function (e){
        $("#items").append('<div>List Item(s): <input type="text" name="list[list_item][]"></div>');
    });
});