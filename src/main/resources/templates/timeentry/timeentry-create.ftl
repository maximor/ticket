<#include "../static-parts/header.ftl">
<#include "../static-parts/sidebar.ftl">
<#if error??>
    <div class="alert alert-danger" id="alert" role="alert">${error}</div>
</#if>
<#if message??>
    <div class="alert alert-success" id="alertsuccess" role="alert">${message}</div>
</#if>
<div class="card">
    <div class="card-header">
        <h3>Time Entry Form</h3>
        <div class="card-header-right">
            <i class="icofont icofont-spinner-alt-5"></i>
        </div>

    </div>
    <div class="card-block">
        <h4 class="sub-title">Ticket Information</h4>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Ticket #:</label>
                <div class="col-sm-10">
                    <#if ticket??>
                        ${ticket.getId()}
                    <#else>
                        N/A
                    </#if>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Subject:</label>
                <div class="col-sm-10">
                    <#if ticket??>
                        ${ticket.getSubject()}
                    <#else>
                        N/A
                    </#if>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Date</label>
                <div class="col-sm-10">
                    <#if ticket??>
                        ${ticket.getCreationDate()}
                    <#else>
                        N/A
                    </#if>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Description</label>
                <div class="col-sm-10">
                    <#if ticket??>
                        ${ticket.getDescription()}
                    <#else>
                        N/A
                    </#if>
                </div>
            </div>
    </div>

    <div class="card-block">
        <h4 class="sub-title">Time Entry Information</h4>
        <form action="<#if ticket??>/timeentry/${ticket.getId()}</#if>" method="post">
            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="subject-input">Employee</label>
                </div>
                <div class="col-sm-10">
                    <select class="form-control" name="idEmployee" id="">
                        <#if users??>
                            <#list users as user>
                                <option value="${user.getId()}">${user.getEmail()}</option>
                            </#list>
                        </#if>

                    </select>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="date-input">Date:</label>
                </div>
                <div class="col-sm-4">
                    <input type="datetime-local" class="form-control" name="initialDate" id="subject-input" required>
                    <div class="col-form-label" id="subject-div"></div>
                </div>
                <div class="col-sm-2 text-center">
                    <label class="col-form-label" for="date-input">To</label>
                </div>
                <div class="col-sm-4">
                    <input type="datetime-local" class="form-control" name="endDate" id="endDate-input" required>
                    <div class="col-form-label" id="subject-div"></div>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-2">
                    <label class="col-form-label" for="email-input">Description:</label>
                </div>
                <div class="col-sm-10">
                    <textarea rows="5" cols="5" class="form-control" name="note"  id="description" placeholder="Type a note for the time entry" required></textarea>
                </div>
            </div>
            <div class="card-footer text-center">
                <#if ticket??>
                    <button class="btn btn-primary" type="submit">Save</button>
                    <a class="btn btn-danger">Cancel</a>
                </#if>
            </div>
        </form>
    </div>

</div>
<#include "../static-parts/footer.ftl">

<script>
    $(document).ready(function(){
        $("#alert").fadeOut(10000);
        $("#alertsuccess").fadeOut(10000);
    });
</script>