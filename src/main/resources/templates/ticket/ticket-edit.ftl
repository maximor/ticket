<#include "../static-parts/header.ftl">
<#include "../static-parts/sidebar.ftl">
<div class="card">
    <div class="card-header">
        <h4>Ticket Form Update</h4>
    </div>
    <div class="card-block">
        <form action="/ticket-edit/${ticket.getId()}" method="post">
            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="subject-input">Subject:</label>
                </div>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="subject" id="subject-input" value="<#if ticket??>${ticket.getSubject()}</#if>" required>
                    <div class="col-form-label" id="subject-div"></div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="lastname-input">Employees:</label>
                </div>
                <div class="col-sm-8">
                    <select class="form-control" id="myselect">
                        <#if users??>
                            <#list users as user>
                                <option value="${user.getEmail()}">${user.getEmail()}</option>
                            </#list>
                        </#if>

                    </select>
                </div>
                <div class="col-sm-2">
                    <a title="add an employee to the list" class="btn btn-primary" onclick="addEmployee()"><i class="ti-check"></i></a>
                    <a title="add an employee to the list" class="btn btn-danger" onclick="deleteEmployee()"><i class="ti-close"></i></a>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
                    <#--                    <label class="col-form-label" for="email-input">Email:</label>-->
                </div>
                <div class="col-sm-10">
                    <input class="form-control" name="employeesfield" id="employeesfield" placeholder="Select an Employee" value="<#if ticket??>${ticket.getEmployeesfield()}</#if>" readonly required>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="email-input">Description:</label>
                </div>
                <div class="col-sm-10">
                    <textarea rows="5" cols="5" class="form-control" name="description"  id="description" placeholder="Type the description for the ticket" required><#if ticket??>${ticket.getDescription()}</#if></textarea>
                </div>
            </div>

            <div class="card-footer text-center">
                <button type="submit" class="btn btn-info">Update</button>
                <a class="btn btn-danger" href="/ticket/view">Cancel</a>
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

    function addEmployee() {
        let email = $("#myselect option:selected").text();

        let employeesfields = $("#employeesfield");
        let values = employeesfields.val();

        let status = true;
        values.split(",").forEach(function (value) {
            if(value != ""){
                if(value == email){
                    status = false;
                }
            }
        })

        if (status){
            employeesfields.val(values+","+email);
        }
    }

    function deleteEmployee() {
        let emails = $("#employeesfield").val();

        if(emails.length > 0){
            let len = emails.split(",").length;
            $("#employeesfield").val(emails.split(",", len - 1));
        }
    }

    $(document).ready(function(){
        $("#alert").fadeOut(10000);
        $("#alertsuccess").fadeOut(10000);
    });
</script>