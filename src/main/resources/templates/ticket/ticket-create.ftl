<#include "../static-parts/header.ftl">
<#include "../static-parts/sidebar.ftl">
<div class="card">
    <div class="card-header">
        <h4>Ticket Form</h4>
    </div>
    <div class="card-block">
        <form action="/ticket/create" method="post">
            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="subject-input">Subject:</label>
                </div>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="subject" id="subject-input" required>
                    <div class="col-form-label" id="subject-div"></div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="lastname-input">Employees:</label>
                </div>
                <div class="col-sm-9">
                    <select class="form-control" id="myselect">
                        <#if users??>
                            <#list users as user>
                                <option value="${user.getEmail()}">${user.getEmail()} </option>
                            </#list>
                        </#if>

                    </select>
                </div>
                <div class="col-sm-1">
                    <a title="add an employee to the list" class="btn btn-primary" onclick="addEmployee()"><i class="ti-check"></i></a>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
<#--                    <label class="col-form-label" for="email-input">Email:</label>-->
                </div>
                <div class="col-sm-10">
                    <input class="form-control" name="employeesfield" id="employeesfield" placeholder="Select an Employee" readonly required>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="email-input">Description:</label>
                </div>
                <div class="col-sm-10">
                    <textarea rows="5" cols="5" class="form-control" name="description"  id="description" placeholder="Type the description for the ticket" required></textarea>
                </div>
            </div>

            <div class="card-footer text-center">
                <button type="submit" class="btn btn-primary">Save</button>
                <a class="btn btn-danger" onclick="cancel()">Cancel</a>
            </div>
        </form>
    </div>
</div>

<#if message??>
    <div class="alert alert-success" id="alertsuccess" role="alert">${message}</div>
</#if>
<#include "../static-parts/footer.ftl">

<script>
    function addEmployee() {
        let email = $("#myselect option:selected").text();

        let employeesfields = $("#employeesfield");
        let values = employeesfields.val();

        let status = true;
        values.split(",").forEach(function (value) {
            if(value != ""){
                console.log(value);
                if(value == email){
                    status = false;
                }
            }
        })

        if (status){
            employeesfields.val(values+","+email);
        }
    }

    function cancel(){
        $("#subject-input").val("");
        $("#employeesfield").val("");
        $("#description").val("");
    }

    $(document).ready(function(){
        $("#alertsuccess").fadeOut(10000);
        $("#alert").fadeOut(10000);
    });
</script>