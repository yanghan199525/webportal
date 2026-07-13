<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Ultimus.UWF.Home.V3.Default" %>

<%@ Import Namespace="Ultimus.UWF.Common.Logic" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <title><%=Lang.Get("Default_ProjectTitle") %></title>
    <link rel="stylesheet" href="../../Common/Assets37/css/base.css" />
    <style>
        .childmenu.mm-active > a {
            font-weight: normal !important;
        }

        .childmenu > a {
            font-size: 16px !important;
            color: #808080 !important;
        }

        .urlmenu > a {
            color: #000 !important;
        }

        .app-sidebar__heading {
            font-weight: 700 !important;
            color: #3f6ad8 !important;
        }

        .vertical-nav-menu li.urlmenu.mm-active > a {
            border-left: 2px solid #3f6ad8;
        }

        .scrollbar-sidebar {
            overflow-y: auto;
        }

            .scrollbar-sidebar::-webkit-scrollbar {
                width: 10px;
                height: 1px;
            }

            .scrollbar-sidebar::-webkit-scrollbar-thumb {
                border-radius: 10px;
                background-color: #ddc7c7;
                /*background-image: -webkit-linear-gradient(45deg, rgba(255, 255, 255, .2) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .2) 50%, rgba(255, 255, 255, .2) 75%, transparent 75%, transparent);*/
            }

            .scrollbar-sidebar::-webkit-scrollbar-track {
                -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
                /*border-radius: 10px;*/
                background: #EDEDED;
            }
        /*opacity是设置遮罩透明度的，可以自己调节*/
        #loading {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: #f8f8f8;
            opacity: 0.8;
            z-index: 15000;
        }

            #loading img {
                position: absolute;
                top: 50%;
                left: 50%;
                width: 33px;
                height: 33px;
                margin-top: -15px;
                margin-left: -15px;
            }

            #loading p {
                position: absolute;
                top: 55%;
                left: 48%;
                width: 33px;
                height: 33px;
                margin-top: -15px;
                margin-left: -15px;
            }
    </style>
</head>
<body class="scrollbar-sidebar">
    <div class="app-container app-theme-white body-tabs-shadow fixed-header fixed-sidebar  ">
        <!--Header START-->
        <div class="app-header header-shadow bg-dark header-text-light">
            <div class="app-header__logo">
                <div class="logo-src" onclick="location.href=location.href;" style="cursor: pointer"></div>
                <div class="header__pane ml-auto">
                    <div>
                        <button type="button" class="hamburger close-sidebar-btn hamburger--elastic" data-class="closed-sidebar">
                            <span class="hamburger-box">
                                <span class="hamburger-inner"></span>
                            </span>
                        </button>
                    </div>
                </div>
            </div>
            <div class="app-header__mobile-menu">
                <div>
                    <button type="button" class="hamburger hamburger--elastic mobile-toggle-nav">
                        <span class="hamburger-box">
                            <span class="hamburger-inner"></span>
                        </span>
                    </button>
                </div>
            </div>
            <div class="app-header__menu">
                <span>
                    <button type="button" class="btn-icon btn-icon-only btn btn-primary btn-sm mobile-toggle-header-nav">
                        <span class="btn-icon-wrapper">
                            <i class="fa fa-ellipsis-v fa-w-6"></i>
                        </span>
                    </button>
                </span>
            </div>
            <div class="app-header__content">
                <div class="app-header-left">
                    <div class="search-wrapper">
                        <div class="input-holder">
                            <input type="text" id="searchbox" class="search-input" placeholder="<%=Lang.Get("btn_Search") %>" />
                            <button class="search-icon" onclick="openSearch();"><span></span></button>
                            <a id="search" href="javascript:void(0);" style="display: none" target="content"></a>
                        </div>
                        <button class="close"></button>
                    </div>
                    <ul class="header-megamenu nav">
                    </ul>
                </div>
                <div class="app-header-right">
                    <div class="header-dots">
                        <div class="dropdown dropdown_apps">
                            <button type="button" aria-haspopup="true" aria-expanded="false" data-toggle="dropdown" class="p-0 mr-2 btn btn-link">
                                <span class="icon-wrapper icon-wrapper-alt rounded-circle">
                                    <span class="icon-wrapper-bg bg-primary"></span>
                                    <i class="icon text-primary ion-android-apps"></i>
                                </span>
                            </button>
                            <div tabindex="-1" role="menu" aria-hidden="true" class="apps dropdown-menu-xl rm-pointers dropdown-menu dropdown-menu-right">
                                <div class="dropdown-menu-header">
                                    <div class="dropdown-menu-header-inner bg-plum-plate">
                                        <div class="menu-header-image" style="background-image: url('../../Common/Assets37/images/dropdown-header/abstract4.jpg');"></div>
                                        <div class="menu-header-content text-white">
                                            <h5 class="menu-header-title">应用中心</h5>
                                            <h6 class="menu-header-subtitle">扩展应用集合，快速定位</h6>
                                        </div>
                                    </div>
                                </div>
                                <div class=" grid-menu grid-menu-xl grid-menu-3col">
                                    <div class='navmore no-gutters row'>
                                    </div>
                                </div>
                                <%--<ul class="nav flex-column">
                                    <li class="nav-item-divider nav-item"></li>
                                    <li class="nav-item-btn text-center nav-item">
                                        <button class="btn-shadow btn btn-primary btn-sm">Follow-ups</button>
                                    </li>
                                </ul>--%>
                            </div>
                        </div>
                        <%-- <div class="dropdown " style="display:none">
                            <button type="button" aria-haspopup="true" aria-expanded="false" data-toggle="dropdown" class="p-0 mr-2 btn btn-link">
                                <span class="icon-wrapper icon-wrapper-alt rounded-circle">
                                    <span class="icon-wrapper-bg bg-danger"></span>
                                    <i class="icon text-danger icon-anim-pulse ion-android-notifications"></i>
                                    <span class="badge badge-dot badge-dot-sm badge-danger">消息通知</span>
                                </span>
                            </button>
                            <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-xl rm-pointers dropdown-menu dropdown-menu-right">
                                <div class="dropdown-menu-header mb-0">
                                    <div class="dropdown-menu-header-inner bg-deep-blue">
                                        <div class="menu-header-image opacity-1" style="background-image: url('../../Common/Assets37/images/dropdown-header/city3.jpg');"></div>
                                        <div class="menu-header-content text-dark">
                                            <h5 class="menu-header-title">消息通知</h5>
                                            <h6 class="menu-header-subtitle">你有收到 <b>21</b>个消息通知</h6>
                                        </div>
                                    </div>
                                </div>
                                <ul class="tabs-animated-shadow tabs-animated nav nav-justified tabs-shadow-bordered p-3">
                                    <li class="nav-item">
                                        <a role="tab" class="nav-link active" data-toggle="tab" href="#tab-messages-header">
                                            <span>信息</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a role="tab" class="nav-link" data-toggle="tab" href="#tab-errors-header">
                                            <span>任务</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a role="tab" class="nav-link" data-toggle="tab" href="#tab-events-header">
                                            <span>事件</span>
                                        </a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="tab-messages-header" role="tabpanel">
                                        <div class="scroll-area-sm">
                                            <div class="scrollbar-container">
                                                <div class="p-3">
                                                    <div class="notifications-box">
                                                        <div class="vertical-time-simple vertical-without-time vertical-timeline vertical-timeline--one-column">
                                                            <div class="vertical-timeline-item dot-danger vertical-timeline-element">
                                                                <div>
                                                                    <span class="vertical-timeline-element-icon bounce-in"></span>
                                                                    <div class="vertical-timeline-element-content bounce-in">
                                                                        <h4 class="timeline-title">全体会议</h4>
                                                                        <span class="vertical-timeline-element-date"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="vertical-timeline-item dot-warning vertical-timeline-element">
                                                                <div>
                                                                    <span class="vertical-timeline-element-icon bounce-in"></span>
                                                                    <div class="vertical-timeline-element-content bounce-in">
                                                                        <p>另一个，在 <span class="text-success">15:00 PM</span></p>
                                                                        <span class="vertical-timeline-element-date"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="vertical-timeline-item dot-success vertical-timeline-element">
                                                                <div>
                                                                    <span class="vertical-timeline-element-icon bounce-in"></span>
                                                                    <div class="vertical-timeline-element-content bounce-in">
                                                                        <h4 class="timeline-title">建立生产发布
                                                                       
                                                                            <span class="badge badge-danger ml-2">NEW</span>
                                                                        </h4>
                                                                        <span class="vertical-timeline-element-date"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="vertical-timeline-item dot-primary vertical-timeline-element">
                                                                <div>
                                                                    <span class="vertical-timeline-element-icon bounce-in"></span>
                                                                    <div class="vertical-timeline-element-content bounce-in">
                                                                        <h4 class="timeline-title">不重要的事
                                                                       
                                                                            <div class="avatar-wrapper mt-2 avatar-wrapper-overlap">
                                                                                <div class="avatar-icon-wrapper avatar-icon-sm">
                                                                                    <div class="avatar-icon">
                                                                                        <img
                                                                                            src="../../Common/Assets37/images/avatars/1.jpg"
                                                                                            alt="">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="avatar-icon-wrapper avatar-icon-sm">
                                                                                    <div class="avatar-icon">
                                                                                        <img
                                                                                            src="../../Common/Assets37/images/avatars/2.jpg"
                                                                                            alt="">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="avatar-icon-wrapper avatar-icon-sm">
                                                                                    <div class="avatar-icon">
                                                                                        <img
                                                                                            src="../../Common/Assets37/images/avatars/3.jpg"
                                                                                            alt="">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="avatar-icon-wrapper avatar-icon-sm">
                                                                                    <div class="avatar-icon">
                                                                                        <img
                                                                                            src="../../Common/Assets37/images/avatars/4.jpg"
                                                                                            alt="">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="avatar-icon-wrapper avatar-icon-sm">
                                                                                    <div class="avatar-icon">
                                                                                        <img
                                                                                            src="../../Common/Assets37/images/avatars/5.jpg"
                                                                                            alt="">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="avatar-icon-wrapper avatar-icon-sm">
                                                                                    <div class="avatar-icon">
                                                                                        <img
                                                                                            src="../../Common/Assets37/images/avatars/9.jpg"
                                                                                            alt="">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="avatar-icon-wrapper avatar-icon-sm">
                                                                                    <div class="avatar-icon">
                                                                                        <img
                                                                                            src="../../Common/Assets37/images/avatars/7.jpg"
                                                                                            alt="">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="avatar-icon-wrapper avatar-icon-sm">
                                                                                    <div class="avatar-icon">
                                                                                        <img
                                                                                            src="../../Common/Assets37/images/avatars/8.jpg"
                                                                                            alt="">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="avatar-icon-wrapper avatar-icon-sm avatar-icon-add">
                                                                                    <div class="avatar-icon"><i>+</i></div>
                                                                                </div>
                                                                            </div>
                                                                        </h4>
                                                                        <span class="vertical-timeline-element-date"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="vertical-timeline-item dot-info vertical-timeline-element">
                                                                <div>
                                                                    <span class="vertical-timeline-element-icon bounce-in"></span>
                                                                    <div class="vertical-timeline-element-content bounce-in">
                                                                        <h4 class="timeline-title">这个点有一个信息状态</h4>
                                                                        <span class="vertical-timeline-element-date"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="vertical-timeline-item dot-danger vertical-timeline-element">
                                                                <div>
                                                                    <span class="vertical-timeline-element-icon bounce-in"></span>
                                                                    <div class="vertical-timeline-element-content bounce-in">
                                                                        <h4 class="timeline-title">全体会议</h4>
                                                                        <span class="vertical-timeline-element-date"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="vertical-timeline-item dot-warning vertical-timeline-element">
                                                                <div>
                                                                    <span class="vertical-timeline-element-icon bounce-in"></span>
                                                                    <div class="vertical-timeline-element-content bounce-in">
                                                                        <p>另一个，在 <span class="text-success">15:00 PM</span></p>
                                                                        <span class="vertical-timeline-element-date"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="vertical-timeline-item dot-success vertical-timeline-element">
                                                                <div>
                                                                    <span class="vertical-timeline-element-icon bounce-in"></span>
                                                                    <div class="vertical-timeline-element-content bounce-in">
                                                                        <h4 class="timeline-title">建立生产发布
                                                                       
                                                                            <span class="badge badge-danger ml-2">NEW</span>
                                                                        </h4>
                                                                        <span class="vertical-timeline-element-date"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="vertical-timeline-item dot-dark vertical-timeline-element">
                                                                <div>
                                                                    <span class="vertical-timeline-element-icon bounce-in"></span>
                                                                    <div class="vertical-timeline-element-content bounce-in">
                                                                        <h4 class="timeline-title">这个点有一个信息状态</h4>
                                                                        <span class="vertical-timeline-element-date"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="tab-events-header" role="tabpanel">
                                        <div class="scroll-area-sm">
                                            <div class="scrollbar-container">
                                                <div class="p-3">
                                                    <div class="vertical-without-time vertical-timeline vertical-timeline--animate vertical-timeline--one-column">
                                                        <div class="vertical-timeline-item vertical-timeline-element">
                                                            <div>
                                                                <span class="vertical-timeline-element-icon bounce-in"><i class="badge badge-dot badge-dot-xl badge-success"></i></span>
                                                                <div class="vertical-timeline-element-content bounce-in">
                                                                    <h4 class="timeline-title">All Hands Meeting</h4>
                                                                    <p>Lorem ipsum dolor sic amet, today at <a href="javascript:void(0);">12:00 PM</a></p>
                                                                    <span class="vertical-timeline-element-date"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="vertical-timeline-item vertical-timeline-element">
                                                            <div>
                                                                <span class="vertical-timeline-element-icon bounce-in"><i class="badge badge-dot badge-dot-xl badge-warning"></i></span>
                                                                <div class="vertical-timeline-element-content bounce-in">
                                                                    <p>Another meeting today, at <b class="text-danger">12:00 PM</b></p>
                                                                    <p>Yet another one, at <span class="text-success">15:00 PM</span></p>
                                                                    <span class="vertical-timeline-element-date"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="vertical-timeline-item vertical-timeline-element">
                                                            <div>
                                                                <span class="vertical-timeline-element-icon bounce-in"><i class="badge badge-dot badge-dot-xl badge-danger"></i></span>
                                                                <div class="vertical-timeline-element-content bounce-in">
                                                                    <h4 class="timeline-title">Build the production release</h4>
                                                                    <p>Lorem ipsum dolor sit amit,consectetur eiusmdd tempor incididunt ut labore et dolore magna elit enim at minim veniam quis nostrud</p>
                                                                    <span
                                                                        class="vertical-timeline-element-date"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="vertical-timeline-item vertical-timeline-element">
                                                            <div>
                                                                <span class="vertical-timeline-element-icon bounce-in"><i class="badge badge-dot badge-dot-xl badge-primary"></i></span>
                                                                <div class="vertical-timeline-element-content bounce-in">
                                                                    <h4 class="timeline-title text-success">Something not important</h4>
                                                                    <p>Lorem ipsum dolor sit amit,consectetur elit enim at minim veniam quis nostrud</p>
                                                                    <span class="vertical-timeline-element-date"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="vertical-timeline-item vertical-timeline-element">
                                                            <div>
                                                                <span class="vertical-timeline-element-icon bounce-in"><i class="badge badge-dot badge-dot-xl badge-success"></i></span>
                                                                <div class="vertical-timeline-element-content bounce-in">
                                                                    <h4 class="timeline-title">All Hands Meeting</h4>
                                                                    <p>Lorem ipsum dolor sic amet, today at <a href="javascript:void(0);">12:00 PM</a></p>
                                                                    <span class="vertical-timeline-element-date"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="vertical-timeline-item vertical-timeline-element">
                                                            <div>
                                                                <span class="vertical-timeline-element-icon bounce-in"><i class="badge badge-dot badge-dot-xl badge-warning"></i></span>
                                                                <div class="vertical-timeline-element-content bounce-in">
                                                                    <p>Another meeting today, at <b class="text-danger">12:00 PM</b></p>
                                                                    <p>Yet another one, at <span class="text-success">15:00 PM</span></p>
                                                                    <span class="vertical-timeline-element-date"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="vertical-timeline-item vertical-timeline-element">
                                                            <div>
                                                                <span class="vertical-timeline-element-icon bounce-in"><i class="badge badge-dot badge-dot-xl badge-danger"></i></span>
                                                                <div class="vertical-timeline-element-content bounce-in">
                                                                    <h4 class="timeline-title">Build the production release</h4>
                                                                    <p>Lorem ipsum dolor sit amit,consectetur eiusmdd tempor incididunt ut labore et dolore magna elit enim at minim veniam quis nostrud</p>
                                                                    <span
                                                                        class="vertical-timeline-element-date"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="vertical-timeline-item vertical-timeline-element">
                                                            <div>
                                                                <span class="vertical-timeline-element-icon bounce-in"><i class="badge badge-dot badge-dot-xl badge-primary"></i></span>
                                                                <div class="vertical-timeline-element-content bounce-in">
                                                                    <h4 class="timeline-title text-success">Something not important</h4>
                                                                    <p>Lorem ipsum dolor sit amit,consectetur elit enim at minim veniam quis nostrud</p>
                                                                    <span class="vertical-timeline-element-date"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="tab-errors-header" role="tabpanel">
                                        <div class="scroll-area-sm">
                                            <div class="scrollbar-container">
                                                <div class="no-results pt-3 pb-0">
                                                    <div class="swal2-icon swal2-success swal2-animate-success-icon">
                                                        <div class="swal2-success-circular-line-left" style="background-color: rgb(255, 255, 255);"></div>
                                                        <span class="swal2-success-line-tip"></span>
                                                        <span class="swal2-success-line-long"></span>
                                                        <div class="swal2-success-ring"></div>
                                                        <div class="swal2-success-fix" style="background-color: rgb(255, 255, 255);"></div>
                                                        <div class="swal2-success-circular-line-right" style="background-color: rgb(255, 255, 255);"></div>
                                                    </div>
                                                    <div class="results-subtitle">干净级了!</div>
                                                    <div class="results-title">现在没有一个任务!</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <ul class="nav flex-column">
                                    <li class="nav-item-divider nav-item"></li>
                                    <li class="nav-item-btn text-center nav-item">
                                        <button class="btn-shadow btn-wide btn-pill btn btn-focus btn-sm">查看最新更改</button>
                                    </li>
                                </ul>
                            </div>
                        </div>--%>
                        <div class="dropdown">
                            <button type="button" data-toggle="dropdown" class="p-0 mr-2 btn btn-link">
                                <span class="icon-wrapper icon-wrapper-alt rounded-circle" title="<%=Lang.Get("SelectLanguage") %>">
                                    <span class="icon-wrapper-bg bg-focus"></span>
                                    <span class="language-icon opacity-8 flag large <%=User_Lang %>"></span>
                                </span>
                            </button>
                            <div tabindex="-1" role="menu" aria-hidden="true" class="apps rm-pointers dropdown-menu dropdown-menu-right">
                                <div class="dropdown-menu-header">
                                    <div class="dropdown-menu-header-inner pt-4 pb-4 bg-focus">
                                        <div class="menu-header-image opacity-05" style="background-image: url('../../Common/Assets37/images/dropdown-header/city2.jpg');"></div>
                                        <div class="menu-header-content text-center text-white">
                                            <h6 class="menu-header-subtitle mt-0"><%=Lang.Get("SelectLanguage") %>
                                            </h6>
                                        </div>
                                    </div>
                                </div>
                                <h6 tabindex="-1" class="dropdown-header"><%=Lang.Get("Language") %>
                                </h6>
                                <button type="button" tabindex="0" class="dropdown-item" onclick="changeLang('en-US');">
                                    <span class="mr-3 opacity-8 flag large GB"></span>
                                    English
                           
                                </button>
                                <button type="button" tabindex="0" class="dropdown-item" onclick="changeLang('zh-CN');">
                                    <span class="mr-3 opacity-8 flag large CN"></span>
                                    中文
                           
                                </button>
                                <%-- <button type="button" tabindex="0" class="dropdown-item" onclick="changeLang('EXT01');">
                                    <span class="mr-3 opacity-8 flag large JP"></span>
                                    日本
                                </button>--%>
                                <%--       <button type="button" tabindex="0" class="dropdown-item">
                                    <span class="mr-3 opacity-8 flag large KR"></span>
                                    韩国
                           
                                </button>
                                <div tabindex="-1" class="dropdown-divider"></div>
                                <h6 tabindex="-1" class="dropdown-header">其它</h6>
                                <button type="button" tabindex="0" class="dropdown-item active">
                                    <span class="mr-3 opacity-8 flag large DE"></span>
                                    德国
                           
                                </button>
                                <button type="button" tabindex="0" class="dropdown-item">
                                    <span class="mr-3 opacity-8 flag large FR"></span>
                                    法国
                           
                                </button>--%>
                            </div>
                        </div>

                        <div class="dropdown">
                            <button type="button" data-toggle="dropdown" id="fullScreen" class="p-0 mr-2 btn  " title="<%=Lang.Get("FullScreen") %>">
                                <span class="icon-wrapper icon-wrapper-alt rounded-circle">
                                    <span class="icon-wrapper-bg bg-primary"></span>
                                    <i id="fs_fa" class="fa fa-expand"></i>
                                </span>
                            </button>

                        </div>

                    </div>

                    <div class="header-btn-lg pr-0" style="padding-left: 10px; margin-left: 10px;">
                        <div class="widget-content p-0">
                            <div class="widget-content-wrapper">
                                <div class="widget-content-left">
                                    <div class="btn-group">
                                        <a data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="p-0 btn">
                                            <img width="42" class="rounded-circle" src="../../Common/Assets37/images/avatars/1.jpg" alt="" />
                                            <span class="widget-content-left  ml-1 header-user-info">
                                                <span id="userName" class="widget-heading"><%=User_FullName %>
                               
                                                </span>
                                            </span>
                                            <i class="fa fa-angle-down ml-2 opacity-8"></i>
                                        </a>


                                        <div tabindex="-1" role="menu" aria-hidden="true" class="apps rm-pointers dropdown-menu-lg dropdown-menu dropdown-menu-right" id="PersonInfo">
                                            <div class="dropdown-menu-header">
                                                <div class="dropdown-menu-header-inner bg-info">
                                                    <div class="menu-header-image opacity-2" style="background-image: url('../../Common/Assets37/images/dropdown-header/city3.jpg');"></div>
                                                    <div class="menu-header-content text-left">
                                                        <div class="widget-content p-0">
                                                            <div class="widget-content-wrapper">
                                                                <div class="widget-content-left mr-3">
                                                                    <img width="42" class="rounded-circle"
                                                                        src="../../Common/Assets37/images/avatars/1.jpg"
                                                                        alt="" />
                                                                </div>
                                                                <div class="widget-content-left">
                                                                    <div class="widget-heading">
                                                                        <%=User_FullName %>
                                                                    </div>
                                                                    <div class="widget-subheading opacity-8">
                                                                        <%=Lang.Get("PersonInfo_Title") %>
                                                                    </div>
                                                                </div>
                                                                <div class="widget-content-right mr-2">
                                                                    <button class="btn-pill btn-shadow btn-shine btn btn-focus" onclick="return logout();">
                                                                        <%=Lang.Get("Default_Logout") %>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="scroll-area-xs" style="height: 100px;">
                                                <div class="scrollbar-container ps">

                                                    <li class="nav-item">
                                                        <a onclick="openFrm('/Portal/Ultimus.UWF.Home.V3/OrgChart/PersonInfo.aspx')" target="content" class="nav-link"><%=Lang.Get("PersonInfo_Title") %>

                                                        </a>
                                                    </li>
                                                    <li hidden class="nav-item">
                                                        <a onclick="openFrm('/Portal/Ultimus.UWF.Home.V3/OrgChart/ChangePassword.aspx?type=1')" target="content" class="nav-link"><% =Lang.Get("ChangePassword") %>
                                                        </a>
                                                    </li>
                                                    </ul>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <%-- <div class="widget-content-left  ml-3 header-user-info">
                                    <div class="widget-heading">
                                        Tina 唐玲
                               
                                    </div>
                                    <div class="widget-subheading">
                                        人事经理
                               
                                    </div>
                                </div>--%>
                                <div class="widget-content-right header-user-info ml-3" style="display: none">
                                    <button type="button" class="btn-shadow p-1 btn btn-primary btn-sm show-toastr-example">
                                        <i class="fa text-white fa-calendar pr-1 pl-1"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>



                </div>
            </div>
        </div>
        <!--Header END-->

        <div class="app-main">
            <div class="app-sidebar sidebar-shadow">
                <div class="app-header__logo">
                    <div class="logo-src"></div>
                    <div class="header__pane ml-auto">
                        <div>
                            <button type="button" class="hamburger close-sidebar-btn hamburger--elastic" data-class="closed-sidebar">
                                <span class="hamburger-box">
                                    <span class="hamburger-inner"></span>
                                </span>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="app-header__mobile-menu">
                    <div>
                        <button type="button" class="hamburger hamburger--elastic mobile-toggle-nav">
                            <span class="hamburger-box">
                                <span class="hamburger-inner"></span>
                            </span>
                        </button>
                    </div>
                </div>
                <div class="app-header__menu">
                    <span>
                        <button type="button" class="btn-icon btn-icon-only btn btn-primary btn-sm mobile-toggle-header-nav">
                            <span class="btn-icon-wrapper">
                                <i class="fa fa-ellipsis-v fa-w-6"></i>
                            </span>
                        </button>
                    </span>
                </div>
                <div class="scrollbar-sidebar">
                    <div class="app-sidebar__inner">
                        <ul class="vertical-nav-menu metismenu">
                        </ul>
                    </div>
                </div>
            </div>
            <div class="app-main__outer">
                <div class="content " id="divContent">
                    <iframe id="frmContent" name="content" src="<%=DefaultForm %>" style="width: 100%;" height="600" scrolling="no" frameborder="0"></iframe>
                </div>
                <!--这个div是为了显示出遮罩效果，loading.gif是在网上搜的,好多好多。。。-->
                <div id="loading" class="list-item" style="display: none">
                    <img alt="" src="../../Common/Assets/img/loading.gif">
                </div>
            </div>
        </div>

    </div>

    <script src="../../Common/Assets37/js/jquery-3.3.1.min.js"></script>
    <script src="../../Common/Assets37/js/bootstrap.bundle.min.js"></script>
    <script src="../../Common/Assets37/js/metismenu.js"></script>
    <script src="../../Common/Assets37/js/scripts-init/app.js"></script>
    <script src="../../Common/Assets37/js/scripts-init/themes-option.js"></script>
    <script>
        if ($('#userName').text().trim() == "") {

        }
        var _fullscreen = false;
        function handleFullScreen() {
            let element = document.documentElement;
            // 判断是否已经是全屏
            // 如果是全屏，退出
            if (_fullscreen) {
                if (document.exitFullscreen) {
                    try {
                        document.exitFullscreen();

                    }
                    catch (e) {
                        document.webkitCancelFullScreen();

                    }
                } else if (document.webkitCancelFullScreen) {
                    document.webkitCancelFullScreen();
                } else if (document.mozCancelFullScreen) {
                    document.mozCancelFullScreen();
                } else if (document.msExitFullscreen) {
                    document.msExitFullscreen();
                }

                $("#fs_fa").addClass("fa-expand")
                $("#fs_fa").removeClass("fa-compress")

            } else {    // 否则，进入全屏
                if (element.requestFullscreen) {
                    element.requestFullscreen();
                } else if (element.webkitRequestFullScreen) {
                    element.webkitRequestFullScreen();
                } else if (element.mozRequestFullScreen) {
                    element.mozRequestFullScreen();
                } else if (element.msRequestFullscreen) {
                    // IE11
                    element.msRequestFullscreen();
                }

                $("#fs_fa").removeClass("fa-expand")
                $("#fs_fa").addClass("fa-compress")

            }
            // 改变当前全屏状态
            _fullscreen = !_fullscreen;
        }

        function logout() {
            location.href = "login.aspx?type=out";
            //location.href = "https://login.microsoftonline.com/a289d6c2-3b1f-4bc4-8fa0-6866ff300052/wsfed?wa=wsignout1.0";
            
        }
        //遮罩层加载
        var a = document.getElementById("frmContent");
        var b = document.getElementById("loading");
        a.style.display = "none"; //隐藏 
        b.style.display = "block"; //显示
        a.onload = function () {
            b.style.display = "none";
            a.style.display = "block";
            //设置iframe 高度
            a.style.height = Math.max(a.contentWindow.document.body.scrollHeight, a.contentWindow.document.documentElement.scrollHeight, 600) + "px";
            document.getElementById("frmContent").style.height = a.style.height;
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }

        function openFrm(url) {
            window.frames[0].location.href = url;
            $(".apps").removeClass("show");
        }


        function frmclick() {
            for (var i = 0; i < window.frames.length; i++) {
                window.frames[i].document.onclick = function () {
                    $(window.parent.document).find(".apps").removeClass("show");
                }

            }
        }

        function mytaskCount(taskcount) {


        }

        function changeLang(lang) {

            $.ajax({
                url: "/Portal/Ultimus.UWF.Home.V3/DefaultHandler.ashx",
                type: "post",
                dataType: "json",
                data: { action: 'changeLang', tdate: (new Date()).getTime(), lang: lang },
                success: function (data) {
                    location.href = location.href;
                    $(".apps").removeClass("show");
                },
                error: function (e) {
                }
            });
        }

        $(function () {
            if ($('#IsOnPostBack').val() == "1") {
                window.location.reload();
            }

            $("#fullScreen").on("click", function () {
                //if ($("#fs_fa").attr("class") == "fa fa-expand") {

                //    fullScreen();
                //}
                //else {

                //    exitFullscreen();
                //}
                handleFullScreen();
            })


            // 用户多语言，用于前端公用
            localStorage.setItem("BPMUserLang",'<%=Lang.GetLang() %>');
            var headerarr = [];
            $('.metismenu').metisMenu();
            frmclick();

            $.ajax({
                url: "/Portal/Ultimus.UWF.Home.V3/DefaultHandler.ashx",
                type: "post",
                dataType: "json",
                data: { action: 'HeaderList', tdate: (new Date()).getTime() },
                success: function (data) {
                    var dataarr = eval(data);
                    dataarr = listToTree(dataarr);
                    var strtree = "", strtreetwo = "";
                    let count = 0;
                    let showmax = 5;
                    $.each(dataarr, function (i, v) {
                        if (v["PARENTID"].trim() == 0) {
                            var str = "";

                            if (count < showmax) {
                                str = "<li class=\"nav-item nav-menuidtop\" data-menuid=\"" + v["MENUID"] + "\">" +
                                    "<a href=\"javascript:void(0);\"data-placement=\"bottom\"rel=\"popover-focus\"data-offset=\"300\"data-toggle=\"popover-custom\"class=\"nav-link\">" +
                                    "<i class=\"" + v["ICON"] + "\"></i>" + v["MappingName"] + "</a></li>";
                                $(".nav").append(str);

                            }
                            else {
                                str =
                                    "<div class='col-sm-6 col-xl-4'  data-menuid=\"" + v["MENUID"] + "\"> " +
                                    "   <button class='btn-icon-vertical btn-square btn-transition btn btn-outline-link'> " +
                                    "     <i class='icon-gradient bg-night-fade btn-icon-wrapper btn-icon-lg mb-3 " + v["ICON"] + "'></i> " +
                                    v["MappingName"] +

                                    "   </button> " +
                                    "</div> ";
                                $(".navmore").append(str);

                            }
                            count++;

                            strtree += "<div class=\"" + v["MENUID"] + "  topmenu\" style=\"display: none;\"><li class=\"app-sidebar__heading\">" + v["MappingName"] + "</li>";

                            $.each(v["children"], function (k, tv) {
                                let str = "";
                                if (k == 0) {
                                    str = " firstmenu";
                                }
                                //2层菜单
                                if (tv["URL"] === "javascript:void(0);") {
                                    strtree += "<li class=\"" + tv["MENUID"] + str + " childmenu\"><a href=\"#\"><i class=\"" + tv["ICON"] + "\"></i>" + tv["MappingName"] + "<i class=\"metismenu-state-icon pe-7s-angle-down caret-left\"></i></a>";
                                } else {
                                    strtree += "<li data-menuid=\"" + tv["MENUID"] + "\" class=\"" + tv["MENUID"] + " urlmenu\"><a href='javascript:void(0);' onclick='openMenu(this,\"" + tv["URL"] + "\")'   target=\"" + tv["TARGET"] + "\"><i class=\"" + tv["ICON"] + "\"></i>" + tv["MappingName"] + "</a>";
                                }
                                //3层菜单
                                if (tv["children"] && tv["children"].length > 0) {
                                    var strtreet = "<ul>";
                                    $.each(tv["children"], function (t, tvt) {

                                        strtreet += "<li data-menuid=\"" + tvt["MENUID"] + "\" class=\"" + tvt["MENUID"] + " urlmenu\"><a href='javascript:void(0);' onclick='openMenu(this,\"" + tvt["URL"] + "\")'  target=\"" + tvt["TARGET"] + "\">" + tvt["MappingName"] + "</a></li>";
                                    });
                                    strtree += strtreet + "</ul>";
                                }
                            });
                            strtree += "</div>";
                        }

                    });

                    if (count <= showmax) {
                        $(".dropdown_apps").hide();
                    }

                    $('.metismenu').metisMenu('dispose');
                    $('.metismenu').append(strtree);
                    $('.metismenu').metisMenu();
                    $(".nav li ").bind("click", function (e) {
                        var _menuid = $(this).data("menuid");
                            <%--if (_menuid == "E85C5755-7430-40DA-B4BD-D5D74480118C") {
                                window.open('<%=MyLib.ConfigurationManager.AppSettings["AdminSite"]%>');
                                e.preventDefault();
                            }
                            else {--%>
                        e.preventDefault();
                        $("." + _menuid).show();
                        $(".urlmenu").removeClass("mm-active");
                        $('.metismenu div').not("." + _menuid).hide();
                        $(".app-container").removeClass("closed-sidebar");
                        //}
                    })

                    $(".urlmenu").bind("click", function (e) {
                        var _menuid = $(this).data("menuid");
                        $('.urlmenu').not("." + _menuid).removeClass("mm-active");
                        $("." + _menuid).addClass("mm-active");

                        document.body.scrollTop = 0;
                        document.documentElement.scrollTop = 0;

                    })

                    $(".navmore div ").bind("click", function (e) {
                        var _menuid = $(this).data("menuid");
                            <%--if (_menuid == "E85C5755-7430-40DA-B4BD-D5D74480118C") {
                                window.open('<%=MyLib.ConfigurationManager.AppSettings["AdminSite"]%>');
                                e.preventDefault();
                            }
                            else {--%>
                        e.preventDefault();
                        $("." + _menuid).show();
                        $(".apps").removeClass("show");
                        $('.metismenu div').not("." + _menuid).hide();
                        //}
                    })


                    $(".nav li").eq(0).click();
                        <%=closedsidebar %>


                    $(".childmenu").addClass("mm-active");
                    $(".childmenu ul").addClass("mm-show");
                    $(".9E91C1EA-0321-4CD7-8704-359EFB2A9E1A").addClass("mm-active");
                },
                error: function (e) {
                    //alert(e.msg);
                }
            });
        })

        function openSearch() {
            var s = $("#searchbox").val();
            if (s) {
                var url = "/Portal/Ultimus.UWF.Home.V3/TaskList?s=" + s;
                //$("#search").attr("href", url);
                $("#frmContent").attr("src", url);

            }

        }

        function openMenu(ele, url) {
            if (ele.target == "content") {
                $("#loading").show();
            }
            if (url.indexOf("{AdminSite}") >= 0) {
                let aa = "<%=MyLib.ConfigurationManager.AppSettings["AdminSite"]%>" + url.replace("{AdminSite}", "");
                $(ele).attr("href", aa);

            }
            else {
                $(ele).attr("href", url);

            }
        }

        //function listToTree(oldArr) {
        //    oldArr.forEach(element => {
        //        let parentId = element.PARENTID;
        //        if (parentId !== 0) {
        //            oldArr.forEach(ele => {
        //                if (ele.MENUID == parentId) {
        //                    if (!ele.children) {
        //                        ele.children = [];
        //                    }
        //                    ele.children.push(element);
        //                }
        //            });
        //        }
        //    });
        //    return oldArr;
        //}


        function listToTree(oldArr) {
            oldArr.forEach(function (element, index) {
                var parentId = element.PARENTID;
                if (parentId !== 0) {
                    oldArr.forEach(function (ele, index) {
                        if (ele.MENUID == parentId) {
                            if (!ele.children) {
                                ele.children = [];
                            }
                            ele.children.push(element);
                        }
                    });
                }
            });
            return oldArr;
        }


    </script>

</body>
</html>
