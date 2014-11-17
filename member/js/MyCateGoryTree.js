$(function () {

    //showCateGoryTree();

    var btnAddCategory = $("#btnAddCategory");
    btnAddCategory.bind('click', function (e) {
        showCateGoryTree();
    });
});

function showCateGoryTree() {
    var TreecategotyId = $("#categotyId").val();
   
    if (TreecategotyId == "") {


        $("#CateGoryTree").empty();
        $("#CateGoryTree").removeClass();
        $("#CateGoryTree").text("请从左侧选择你要代销的商品类目!");
        $("#CateGoryTree").addClass("stips01 mt10  category_tips");
    }
    else {
        $("#CateGoryTree").empty();
        $("#CateGoryTree").removeClass();
        $("#CateGoryTree").text("如需修改请从左侧修改并添加!");
        $("#CateGoryTree").addClass("stips01 mt10  category_tips");
    }
}