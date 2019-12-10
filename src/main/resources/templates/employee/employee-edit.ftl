<#include "../static-parts/header.ftl">
<#include "../static-parts/sidebar.ftl">
<div class="card">
    <div class="card-header">
        <h4>Employee Form</h4>
    </div>
    <div class="card-block">
        <form action="/employee/<#if user??>${user.getId()}</#if>" method="post">
            <input type="number" name="id" value="<#if user??>${user.getId()}</#if>" hidden>
            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="firstname-input">First Name:</label>
                </div>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="firstname" id="firstname-input"
                           value="<#if user??>${user.getFirstname()}</#if>" required>
                    <div class="col-form-label" id="firstname-div"></div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="lastname-input">Last Name:</label>
                </div>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="lastname" id="lastname-input"
                           value="<#if user??>${user.getLastname()}</#if>"  required>
                    <div class="col-form-label" id="lastname-div"></div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="email-input">Email:</label>
                </div>
                <div class="col-sm-10">
                    <input type="email" class="form-control" name="email" id="email-input"
                           value="<#if user??>${user.getEmail()}</#if>"  required>
                    <div class="col-form-label" id="email-div"></div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="status-input">Status:</label>
                </div>
                <div class="col-sm-10">
                    <select class="form-control" name="status" id="status">
                        <#if user??>
                            <#if user.isStatus() == true>
                                <option value="true" selected>Active</option>
                                <option value="false">Disabled</option>
                            <#else>
                                <option value="true">Active</option>
                                <option value="false" selected>Disabled</option>
                            </#if>
                        <#else>
                            <option value="true">Active</option>
                            <option value="false">Disabled</option>
                        </#if>

                    </select>
                </div>
            </div>

            <div class="card-footer text-center">
                <#if error??>

                <#else>
                    <button type="submit" class="btn btn-info">Update</button>
                </#if>
                <a class="btn btn-default" href="/employee/view">Return to View</a>
            </div>
        </form>
    </div>
</div>

<#if error??>
    <div class="alert alert-danger" id="alert" role="alert">${error}</div>
</#if>

<#if message??>
    <div class="alert alert-success" id="alertsuccess" role="alert">${message}</div>
</#if>

<#include "../static-parts/footer.ftl">
<script>
    function cancel(){
        $("#firstname-input").val("");
        $("#lastname-input").val("");
        $("#email-input").val("");
        $("#status-input").val("true");
        $("#password-input").val("");
        $("#confirm-input").val("");
    }

    $(document).ready(function(){
        $("#alert").fadeOut(10000);
        $("#alertsuccess").fadeOut(10000);
    });
</script>