<#include "static-parts/header.ftl">
<#include "static-parts/sidebar.ftl">
<#if error??>
    <div class="alert alert-danger" id="alert" role="alert">${error}</div>
</#if>

<#if message??>
    <div class="alert alert-success" id="alertsuccess" role="alert">${message}</div>
</#if>
<div class="main-body">

    <div class="card">
        <div class="card-header">
            <h4>User Information</h4>
        </div>
        <div class="card-block">
            <form action="/profile" method="post">
                <div class="form-group row">
                    <div class="col-sm-2">
                        <label class="col-form-label" for="firstname-input">First Name:</label>
                    </div>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="firstname" id="firstname-input" value="<#if firstname??>${firstname}</#if>">
                        <div class="col-form-label" id="firstname-div"></div>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-2">
                        <label class="col-form-label" for="lastname-input">Last Name:</label>
                    </div>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="lastname" id="lastname-input" value="<#if lastname??>${lastname}</#if>">
                        <div class="col-form-label" id="lastname-div"></div>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-2">
                        <label class="col-form-label" for="email-input">Email:</label>
                    </div>
                    <div class="col-sm-10">
                        <input type="email" class="form-control" name="email" id="email-input" value="<#if email??>${email}</#if>">
                        <div class="col-form-label" id="email-div"></div>
                    </div>
                </div>
                <div class="card-footer text-center">
                    <button type="submit" name="userInfo" value="update" class="btn btn-info">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="main-body">
    <div class="card">
        <div class="card-header">
            <h4>Change Password</h4>
        </div>
        <div class="card-block">
            <form action="/profile" method="post">
                <div class="form-group row">
                    <div class="col-sm-2">
                        <label class="col-form-label" for="status-input">Your Password:</label>
                    </div>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" name="oldPassword"  id="oldPassword" placeholder="Insert your old password" required>
                    </div>
                </div>


                <div class="form-group row" id="password-div-row">
                    <div class="col-sm-2">
                        <label class="col-form-label" for="password-input">New Password:</label>
                    </div>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" name="newPassword" id="password-input" placeholder="Insert your new password" required>
                        <div class="col-form-label" id="password-div"></div>
                    </div>
                </div>

                <div class="form-group row" id="confirm-div-row">
                    <div class="col-sm-2">
                        <label class="col-form-label" for="confirm-input">Confirm New Password:</label>
                    </div>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="confirm-input" placeholder="Confirm your new password" required>
                        <div class="col-form-label" id="confirm-div"></div>
                    </div>
                </div>

                <div class="card-footer text-center">
                    <button type="submit" class="btn btn-primary" name="userInfo" value="change-password">Change Password</button>
                    <button class="btn btn-danger" onclick="cancel()">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</div>
<#include "static-parts/footer.ftl">
<script>
    $(document).ready(function(){
        $("#alertsuccess").fadeOut(10000);
        $("#alert").fadeOut(10000);
    });

    function cancel() {
        $("#oldPassword").val('');
        $("#password-input").val('');
        $("#confirm-input").val('');
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
        if ($("#confirm-input").val() != $("#password-input").val()) {
            $("#password-input").addClass("form-control-danger");
            $("#password-div-row").addClass("has-danger");
            $("#confirm-input").addClass("form-control-danger");
            $("#confirm-div-row").addClass("has-danger")
            $("#confirm-div").text("Error, The password doesn't match!");
            $(this).focus();
            return false;
        } else {
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
</script>