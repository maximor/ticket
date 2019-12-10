<#include "../static-parts/header.ftl">
<#include "../static-parts/sidebar.ftl">
<!-- Basic table card start -->
<div class="card">
    <div class="card-header">
        <h4>List of Employees</h4>
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
        <a class="btn btn-primary float-right" href="/employee/create">Create Employee</a>
    </div>
    <div class="card-block table-border-style">
        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Date Created</th>
                    <th>Status</th>
                    <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <#if users??>
                    <#list users as user>
                        <tr>
                            <th scope="row">${user.getId()}</th>
                            <td>${user.getFirstname()}</td>
                            <td>${user.getLastname()}</td>
                            <td>${user.getEmail()}</td>
                            <td>${user.getCreationDate()}</td>
                            <td>
                                <#if user.isStatus()>
                                   Active
                                <#else>
                                    Disabled
                                </#if>
                            </td>
                            <td class="text-center">
                                <#if user.getRoles()[0].getName() != "ROLE_ADMIN" >
                                    <a class="btn btn-primary" href="/employee/${user.getId()}"><i class="ti-pencil"></i></a>
                                    <button class="btn btn-danger" onclick="deletef(${user.getId()})" href="#!"><i class="ti-close"></i></button>
                                <#else>
                                    <a class="btn btn-primary" href="/employee/${user.getId()}"><i class="ti-pencil"></i></a>
                                </#if>
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
        var confirmation = confirm("Are you sure you want to delete this user?");
        if(confirmation){
            $.ajax({
                url: '/employee/'+id+'/delete',
                type: 'delete',
                success:function(result){
                    window.location.href = "http://localhost/employee/view"
                }

            });
        }
    }
</script>