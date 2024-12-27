$(document).ready(function () {
    $("#PartnersTable tr").each(function (index) {
        var id = $(this).find(".details").prop("id");
        $(this).attr("onclick", id + ".click()");
        if (index == 1) {
            const params = new Proxy(new URLSearchParams(window.location.search), {
                get: (searchParams, prop) => searchParams.get(prop),
            });
            let value = params.NewPartnerAdded;
            if (value === 'true') {
                $(this).css('background', 'rgba(255, 0, 0,5%)');
            }
        }
    });

    function CheckPolicy() {

        $.ajax({
            type: "post",
            url: "Default.aspx/CheckPolicyCountAndAmount",
            contentType: "application/json; charset=utf-8",
            data: "{}",
            dataType: "json",
            success: function (result) {
                if (result.d.length > 0) {
                    $("#PartnersTable tr").each(function (index) {

                        if ($(this).attr("key") !== undefined && result.d.indexOf(parseInt($(this).attr("key"))) !== -1) {
                            var FullName = $(this).find(".FullName");
                            if (FullName.text().indexOf("*") === -1) { FullName.text("* " + FullName.text()) }
                        }
                    });

                }

            },
            error: function (result) {
                alert('error occured');
            },
            async: true
        });
    }


    setInterval(function () {

        $.ajax({
            type: "post",
            url: "Default.aspx/CheckPolicyCountAndAmount",
            contentType: "application/json; charset=utf-8",
            data: "{}",
            dataType: "json",
            success: function (result) {
                if (result.d.length > 0) {
                    $("#PartnersTable tr").each(function (index) {

                        if ($(this).attr("key") !== undefined && result.d.indexOf(parseInt($(this).attr("key"))) !== -1) {
                            var FullName = $(this).find(".FullName");
                            if (FullName.text().indexOf("*") === -1) { FullName.text("* " + FullName.text()) }
                        }
                    });

                }

            },
            error: function (result) {
                alert('error occured');
            },
            async: true
        });

    }, 500);

});
