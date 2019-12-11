<#include "../static-parts/header.ftl">
<#include "../static-parts/sidebar.ftl">
<!-- Basic table card start -->
<div class="card">
    <div class="card-header">
        <h4>List of Tickets</h4>
        <div class="card-header-right">
            <ul class="list-unstyled card-option">
                <li><i class="fa fa-chevron-left"></i></li>
                <li><i class="fa fa-window-maximize full-card"></i></li>
                <li><i class="fa fa-minus minimize-card"></i></li>
                <#--                <li><i class="fa fa-refresh reload-card"></i></li>-->
                <#--                <li><i class="fa fa-times close-card"></i></li>-->
            </ul>
        </div>
    </div>
    <div class="card-header">
        <a class="btn btn-primary float-right" href="/ticket/create">Create Ticket</a>
    </div>
    <div class="card-block table-border-style">
        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th>Ticket #</th>
                    <th>Subject</th>
                    <th>Description</th>
                    <th>Employee(s)</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <#if tickets??>
                    <#list tickets as ticket>
                        <tr>
                            <th scope="row">${ticket.getId()}</th>
                            <td title="${ticket.getSubject()}">
                                <#if (ticket.getSubject()?length > 16) >
                                    ${ticket.getSubject()?substring(0,16)}...
                                <#else>
                                    ${ticket.getSubject()}
                                </#if>
                            </td>
                            <td title="${ticket.getDescription()}">
                                <#if (ticket.getDescription()?length > 16)>
                                    ${ticket.getDescription()?substring(0,16)}...
                                <#else>
                                    ${ticket.getDescription()}
                                </#if>
                            </td>
                            <td>
                                <#if (ticket.getEmployeesfield()?length > 0)>
                                    ${ticket.getEmployeesfield()?substring(1)}
                                </#if>
                            </td>
                            <td>${ticket.getCreationDate()}</td>
                            <td>
                                <#if ticket.isStatus()>
                                    Open
                                <#else>
                                    Close
                                </#if>
                            </td>
                            <td class="text-center">
                                <a class="btn btn-info" href="/ticket/${ticket.getId()}"><i class="ti-eye"></i></a>
                                <a class="btn btn-primary" href="/ticket-edit/${ticket.getId()}"><i class="ti-pencil"></i></a>
                                <a class="btn btn-danger" onclick="deletef(${ticket.getId()})"><i class="ti-close"></i></a>
                            </td>
                        </tr>
                    </#list>
                </#if>

                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- Basic table card end -->
<#include "../static-parts/footer.ftl">

<script>
    function deletef(id) {
        var confirmation = confirm("Are you sure you want to delete this ticket?");
        if(confirmation){
            $.ajax({
                url: '/ticket/'+id+'/delete',
                type: 'delete',
                success:function(result){
                    window.location.href = "http://localhost/ticket/view"
                }

            });
        }
    }
</script>