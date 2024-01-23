$(() => {
    const idVal = $("#id").val();
    const pwVal = $("#password").val();

    $(".sign").click(() => {
        $.ajax({ // 본인 확인
            type: "post",
            url: "/member/ajaxDeleteCheck.jsp",
            dataType: "json",
            data: {
                idVal : idVal,
                pwVal : pwVal
            },
            success: (res) => {
                res = JSON.parse(res);
                if (!res) {
                    alert("아이디 혹은 비밀번호가 틀렸습니다.");
                    return false;
                }
                else {
                    alert("회원탈퇴가 완료되었습니다.");
                }
            }
        });
    });
})