<#include "../static-parts/header.ftl">
<#include "../static-parts/sidebar.ftl">

<#if error??>
    <div class="alert alert-danger" id="alert" role="alert">${error}</div>
</#if>

<div class="card">
    <div class="card-header">
        <h3>Ticket #
            <#if ticket??>
                ${ticket.getId()}
            <#else>
                N/A
            </#if>
        </h3>
        <div class="card-header text-center">
            <#if ticket??>
                <a class="btn btn-info" href="/ticket-edit/${ticket.getId()}">Edit</a>
                <a class="btn btn-danger" onclick="cancel()">Cancel</a>
            </#if>
        </div>

        <div class="card-header-right">
            <i class="icofont icofont-spinner-alt-5"></i>
        </div>

    </div>
    <div class="card-block">
        <h4 class="sub-title">TICKET DETAILS</h4>
        <form>
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
        </form>
    </div>

    <div class="col-lg-12 col-xl-6">
<#--        <div class="sub-title">Default</div>-->
        <!-- Nav tabs -->
        <ul class="nav nav-tabs  tabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#home1" role="tab">Time Entries</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#profile1" role="tab">Employees</a>
            </li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content tabs card-block">
<#--            Time entry content-->
            <div class="tab-pane active" id="home1" role="tabpanel">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Employee</th>
                        <th>Date</th>
                        <th>Description</th>

                        <th class="text-center">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if ticket?? && ticket.getTimeEntries()??>
                        <#list ticket.getTimeEntries() as timeEntry>
                            <tr>
                                <th scope="row">
                                    <#list timeEntry.getEmployees() as employee>
                                        ${employee.getFirstname()} ${employee.getLastname()}
                                    </#list>
                                </th>
                                <td>
                                   ${timeEntry.getEndDate()}
                                </td>
                                <td >
                                    ${timeEntry.getNote()}
                                </td>
                                <td class="text-center">
                                    <a class="btn btn-primary" href="/employee/"><i class="ti-pencil"></i></a>
                                    <a class="btn btn-danger" onclick="deletef()" href="#!"><i class="ti-close"></i></a>
                                </td>
                            </tr>
                        </#list>
                    </#if>

                    </tbody>
                </table>
            </div>
<#--            Employees Content-->
            <div class="tab-pane" id="profile1" role="tabpanel">
                <table class="table">
                    <thead>
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>

                        <th class="text-center">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if ticket?? && ticket.getEmployees()??>
                        <#list ticket.getEmployees() as employee>
                            <tr>
                                <th scope="row">
                                    ${employee.getFirstname()}
                                </th>
                                <td>
                                    ${employee.getLastname()}
                                </td>
                                <td >
                                    ${employee.getEmail()}
                                </td>
                                <td class="text-center">
                                    <a class="btn btn-info" href="/employee/${employee.getId()}"><i class="ti-eye"></i></a>
                                    <a class="btn btn-danger" onclick="deleteTicketEmployee(${ticket.getId()}, ${employee.getId()})" href="#!"><i class="ti-close"></i></a>
                                </td>
                            </tr>
                        </#list>
                    </#if>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<#include "../static-parts/footer.ftl">
<script>
    $(document).ready(function(){
        $("#alert").fadeOut(10000);
        $("#alertsuccess").fadeOut(10000);
    });

    function deleteTicketEmployee(id, idEmployee) {
        var confirmation = confirm("Are you sure you want to delete this ticket?");
        if(confirmation){
            $.ajax({
                url: '/ticket/'+id+'/employee/'+idEmployee+'/delete',
                type: 'delete',
                success:function(result){
                    window.location.href = "http://localhost/ticket/"+id;
                }

            });
        }
    }


</script>