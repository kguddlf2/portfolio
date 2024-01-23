$(() => {
    // 사용할 문구
    const msg = {
        id : {
            red1 : "아이디는 6 ~ 20자의 영문, 숫자만 사용 가능합니다.",
            red2 : "중복된 아이디입니다.",
            green : "사용 가능한 아이디입니다."
        },
        pw : {
            red : "비밀번호는 8 ~ 20자의 영문, 숫자, 특수문자를 모두 사용해야 합니다.",
            green : "사용 가능한 비밀번호입니다."
        },
        pwRe : {
            red : "비밀번호가 틀립니다.",
            green : "비밀번호가 일치합니다."
        }
    }

    // 정규 표현식
    const regexId = /^[A-Za-z0-9]{6,20}$/;
    const regexPw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;

    // 아이디 검사
    $("#id").keyup(() => {
        const idVal = $("#id").val(); // 아이디 입력값
        const idCheck = $(".idCheck"); // 아이디 유효성검사 결과 노드
        // console.log(idVal);

        if (idVal == "") {
            idCheck.addClass("d-none");
        } else if (regexId.test(idVal)) {
            $.ajax({ // 아이디 중복검사
                type: "post",
                url: "/member/ajaxIdCheck.jsp",
                dataType: "json",
                data: {idVal : idVal},
                success: (res) => {
                    res = JSON.parse(res);
                    // console.log(res);
                    if (res) {
                        idCheck.text(msg.id.red2).removeClass("text-success d-none").addClass("text-danger");
                    }
                    else {
                        idCheck.text(msg.id.green).removeClass("text-danger d-none").addClass("text-success");
                    }
                }
            });
        } else {
            idCheck.text(msg.id.red1).removeClass("text-success d-none").addClass("text-danger");
        }
    });

    // 비밀번호 검사
    $("#password").keyup(() => {
        const pwVal = $("#password").val(); // 비밀번호 입력값
        const pwCheck = $(".passwordCheck"); // 비밀번호 유효성검사 결과 노드

        if (pwVal == "") {
            pwCheck.addClass("d-none");
        } else if (regexPw.test(pwVal)) {
            pwCheck.text(msg.pw.green).removeClass("text-danger d-none").addClass("text-success");
        } else {
            pwCheck.text(msg.pw.red).removeClass("text-success d-none").addClass("text-danger");
        }
    });

    // 비밀번호 확인 검사
    $("#passwordRe").keyup(() => {
        const pwVal = $("#password").val(); // 비밀번호 입력값
        const pwReVal = $("#passwordRe").val(); // 비밀번호 확인 입력값
        const pwReCheck = $(".passwordReCheck"); // 비밀번호 확인 검사 결과 노드

        if (pwReVal == "") {
            pwReCheck.addClass("d-none");
        } else if (pwReVal == pwVal) {
            pwReCheck.text(msg.pwRe.green).removeClass("text-danger d-none").addClass("text-success");
        } else {
            pwReCheck.text(msg.pwRe.red).removeClass("text-success d-none").addClass("text-danger");
        }
    });

    // 유효성 검사
    $(".sign").click(() => {
        if ($("#name").val() == "") {
            alert("이름을 적어주세요.");
            return false;
        } else if (!($(".idCheck").hasClass("text-success"))) {
            alert("아이디를 확인해주세요.");
            return false;
        } else if (!($(".passwordCheck").hasClass("text-success"))) {
            alert("비밀번호를 확인해주세요.");
            return false;
        } else if (!($(".passwordReCheck").hasClass("text-success"))) {
            alert("비밀번호 확인이 틀렸습니다.");
            return false;
        } else {
            alert("회원가입이 완료되었습니다.");
        }
    });
});