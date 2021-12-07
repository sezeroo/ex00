var memberService = (function(){
    console.log("memberService")

    function get(param,callback,error){
        var memberID = param.id;

        $.getJSON("/member/updateMember/"+memberID+".json",
            function(data){
                if(callback){
                    callback(data)
                    console.log("data callback 성공");

                }
            }).fail(function(xhr,status,err){
            if(error){
                error();
            }
        });
    console.log("ajax 실행");
    }



    return {
        get:get

    };
})();