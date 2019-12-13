<#include "./static-parts/header.ftl">
<#include "./static-parts/sidebar.ftl">
<div class="card">
    <div class="card-header">
        <h4>Generate Report</h4>
        <div class="card-header-right">
            <ul class="list-unstyled card-option">
                <li><i class="fa fa-chevron-left"></i></li>
                <li><i class="fa fa-window-maximize full-card"></i></li>
                <li><i class="fa fa-minus minimize-card"></i></li>
            </ul>
        </div>
        <form action="/report" method="post">
            <div class="row">
                <div class="col-sm-6">

                </div>
                <div class="col-sm-6 float-right">
                    <div class="row">
                        <div class="col-sm-4">
                            <input class="form-control" type="date" name="initialDate">
                        </div>
                        <div class="col-sm-1 text-center">
                            To
                        </div>
                        <div class="col-sm-4">
                            <input class="form-control" type="date" name="endDate">
                        </div>
                        <div class="col-sm-3 text-center">
                            <button type="submit" class="btn btn-primary">Generate</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>


    </div>
    <div class="card-block table-border-style">
        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th>Ticket #</th>
                    <th>Employee</th>
                    <th>Note</th>
                    <th>Date Start</th>
                    <th>Date End</th>
                    <th>Hours</th>
                </tr>
                </thead>
                <tbody>
                <#if timeEntries??>
                    <#list timeEntries as timeEntry>
                        <tr>
                            <th scope="row">${timeEntry.getTicket().getId()}</th>
                            <td>
                                ${timeEntry.getEmployees()[0].getFirstname()} ${timeEntry.getEmployees()[0].getLastname()}
                            </td>
                            <td>
                                <#if (timeEntry.getNote()?length > 32)>
                                    ${timeEntry.getNote()?substring(0, 32)}...
                                <#else>
                                    ${timeEntry.getNote()}
                                </#if>
                            </td>
                            <td>${timeEntry.getInitialDate()}</td>
                            <td>${timeEntry.getEndDate()}</td>
                            <td>${timeEntry.getHours()?string("0.##")}</td>
                        </tr>
                    </#list>
                </#if>
                </tbody>
                <tfooter>
                    <tr>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th class="text-right"><#if totalHours??>Total: </#if> </th>
                        <th><#if totalHours??>${totalHours?string("0.##")}</#if></th>
                    </tr>
                </tfooter>
            </table>
        </div>
    </div>
</div>
<#include "./static-parts/footer.ftl">