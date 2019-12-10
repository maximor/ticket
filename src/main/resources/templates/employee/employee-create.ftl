<#include "../static-parts/header.ftl">
<#include "../static-parts/sidebar.ftl">
<div class="card">
    <div class="card-header">
        <h4>Employee Form</h4>
    </div>
    <div class="card-block">
        <form action="/employee/create" method="post">
            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="firstname-input">First Name:</label>
                </div>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="firstname" id="firstname-input" required>
                    <div class="col-form-label" id="firstname-div"></div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="lastname-input">Last Name:</label>
                </div>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="lastname" id="lastname-input" required>
                    <div class="col-form-label" id="lastname-div"></div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="email-input">Email:</label>
                </div>
                <div class="col-sm-10">
                    <input type="email" class="form-control" name="email" id="email-input" required>
                    <div class="col-form-label" id="email-div"></div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="status-input">Status:</label>
                </div>
                <div class="col-sm-10">
                    <select class="form-control" name="status" id="status-input">
                        <option value="true" selected>Active</option>
                        <option value="false">Disabled</option>
                    </select>
                </div>
            </div>


            <div class="form-group row" id="password-div-row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="password-input">Password:</label>
                </div>
                <div class="col-sm-10">
                    <input type="password" class="form-control" name="password" id="password-input" required>
                    <div class="col-form-label" id="password-div"></div>
                </div>
            </div>

            <div class="form-group row" id="confirm-div-row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="confirm-input">Confirm Password:</label>
                </div>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="confirm-input" required>
                    <div class="col-form-label" id="confirm-div"></div>
                </div>
            </div>

            <div class="card-footer text-center">
                <button type="submit" class="btn btn-primary">Save</button>
                <button class="btn btn-danger" onclick="cancel()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<#if message??>
    <div class="alert alert-success" id="alertsuccess" role="alert">${message}</div>
</#if>

<#if error??>
    <div class="alert alert-danger" id="alert" role="alert">${error}</div>
</#if>

<#include "../static-parts/footer.ftl">
<script>
    //cancel function
    function cancel(){
        $("#firstname-input").val("");
        $("#lastname-input").val("");
        $("#email-input").val("");
        $("#status-input").val("true");
        $("#password-input").val("");
        $("#confirm-input").val("");
    }

    //checks the length of the password
    $("#password-input").on("blur", function () {
        if(this.value.length < 5){
            $("#password-input").addClass("form-control-danger");
            $("#password-div-row").addClass("has-danger");
            $("#password-div").text("Sorry, The password should be minimum 5 characters length.");
            $(this).focus();
            return false;
        }else{
            $("#password-input").removeClass("form-control-danger");
            $("#password-div-row").removeClass("has-danger");
            $("#password-div").text("");
            return false;
        }
    });

    //password confirmation validation
    $("#confirm-input").on("blur", function () {
        if($("#confirm-input").val() != $("#password-input").val()){
            $("#password-input").addClass("form-control-danger");
            $("#password-div-row").addClass("has-danger");
            $("#confirm-input").addClass("form-control-danger");
            $("#confirm-div-row").addClass("has-danger")
            $("#confirm-div").text("Error, The password doesn't match!");
            $(this).focus();
            return false;
        }else{
            $("#password-input").removeClass("form-control-danger");
            $("#password-div-row").removeClass("has-danger");
            $("#confirm-input").removeClass("form-control-danger");
            $("#confirm-div-row").removeClass("has-danger")

            $("#password-input").addClass("form-control-success");
            $("#password-div-row").addClass("has-success");
            $("#confirm-input").addClass("form-control-success");
            $("#confirm-div-row").addClass("has-success")
            $("#confirm-div").text("");
            return false;
        }
    });

    $(document).ready(function(){
        $("#alert-success").fadeOut(10000);
        $("#alert").fadeOut(10000);
    });
</script>