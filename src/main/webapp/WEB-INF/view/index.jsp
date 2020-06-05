<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="/resources/favicon.ico"/>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

    <title>Survly - super ankiety!</title>
</head>
<body>
<div class="screen position-relative overflow-hidden text-center bg-light">
    <div class="col-md-5 p-lg-5 mx-auto my-5">
        <h1 class="display-4 font-weight-normal">Survly! super ankiety!</h1>
        <p class="lead font-weight-normal">Dzięki tej aplikacji będziesz mógł łatwo stworzyć ankietę i zebrać opinie użytkowników!</p>
        <a href="/survey/99" type="button" class="btn btn-primary">Przykładowa ankieta</a>
        <a href="/login" type="button" class="btn btn-info">Panel logowania</a>
    </div>
    <div class="product-device box-shadow d-none d-md-block"></div>
    <div class="product-device product-device-2 box-shadow d-none d-md-block"></div>
</div>
<div class="bg-primary">
    <div class="container-fluid p-0">
        <div class="row no-gutters">
            <div class="col p-3 text-white opis-produktu" style="padding-left: calc(50vw - 250px);">
                <h1>Pięknie zaprojektowany panel administracyjny</h1>
            </div>
            <div class="col bg-white"><img style="width: 100%;" class="img-fluid" src="/resources/img/screen.png" alt=""></div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-12 text-center  p-lg-5 mx-auto my-5">
            <h1 class="mb-5">Nowoczesny stack technologiczny</h1>
            <section class="customer-logos slider">
                <div class="slide"><img src="/resources/img/java.jpg"></div>
                <div class="slide"><img src="/resources/img/spring.png"></div>
                <div class="slide"><img src="/resources/img/hibernate.png"></div>
                <div class="slide"><img src="/resources/img/mysql.png"></div>
                <div class="slide"><img src="/resources/img/vue.png"></div>
                <div class="slide"><img src="/resources/img/html.png"></div>
                <div class="slide"><img src="/resources/img/css.png"></div>
                <div class="slide"><img src="/resources/img/js.png"></div>
            </section>
        </div>
    </div>
</div>

<div class="bg-primary">
    <div class="container-fluid p-0">
        <div class="row no-gutters">
            <div class="col bg-dark"><img class="img-fluid  float-right" src="/resources/img/screen2.png" alt=""></div>
            <div class="col p-3 text-white opis-produktu">
                <h1>Wygodny panel do tworzenia ankiet</h1>
            </div>
        </div>
    </div>
</div>


<div class="bg-primary">
    <div class="container-fluid p-0">
        <div class="row no-gutters">
            <div class="col p-3 text-white opis-produktu">
                <h1>Możliwość tworzenia logiki wyświetlania pól</h1>
            </div>
            <div class="col bg-dark"><img class="img-fluid  float-right" src="/resources/img/screen3.png" alt=""></div>
        </div>
    </div>
</div>


<style>
    .opis-produktu {
        align-items: center;
        justify-content: center;
        display: flex;
        flex-direction: column;
    }



    .slick-slide {
        text-align: center;
    }

    .slick-slide::before {
        content: '';
        display: inline-block;
        height: 100%;
        vertical-align: middle;
    }

    .slick-slide img {
        vertical-align: middle;
        display: inline-block;
    }


/*  Slider  */
    h2{
        text-align:center;
        padding: 20px;
    }
    /* Slider */

    .slick-slide {
        margin: 0px 20px;
    }

    .slick-slide img {
        width: 100%;
    }

    .slick-slider
    {
        position: relative;
        display: block;
        box-sizing: border-box;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        -webkit-touch-callout: none;
        -khtml-user-select: none;
        -ms-touch-action: pan-y;
        touch-action: pan-y;
        -webkit-tap-highlight-color: transparent;
    }

    .slick-list
    {
        position: relative;
        display: block;
        overflow: hidden;
        margin: 0;
        padding: 0;
    }
    .slick-list:focus
    {
        outline: none;
    }
    .slick-list.dragging
    {
        cursor: pointer;
        cursor: hand;
    }

    .slick-slider .slick-track,
    .slick-slider .slick-list
    {
        -webkit-transform: translate3d(0, 0, 0);
        -moz-transform: translate3d(0, 0, 0);
        -ms-transform: translate3d(0, 0, 0);
        -o-transform: translate3d(0, 0, 0);
        transform: translate3d(0, 0, 0);
    }

    .slick-track
    {
        position: relative;
        top: 0;
        left: 0;
        display: block;
    }
    .slick-track:before,
    .slick-track:after
    {
        display: table;
        content: '';
    }
    .slick-track:after
    {
        clear: both;
    }
    .slick-loading .slick-track
    {
        visibility: hidden;
    }

    .slick-slide
    {
        display: none;
        float: left;
        height: 100%;
        min-height: 1px;
    }
    [dir='rtl'] .slick-slide
    {
        float: right;
    }
    .slick-slide img
    {
        display: block;
    }
    .slick-slide.slick-loading img
    {
        display: none;
    }
    .slick-slide.dragging img
    {
        pointer-events: none;
    }
    .slick-initialized .slick-slide
    {
        display: block;
    }
    .slick-loading .slick-slide
    {
        visibility: hidden;
    }
    .slick-vertical .slick-slide
    {
        display: block;
        height: auto;
        border: 1px solid transparent;
    }
    .slick-arrow.slick-hidden {
        display: none;
    }
</style>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
<script>
    $(document).ready(function(){
        $('.customer-logos').slick({
            centerMode: true,
            slidesToShow: 6,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 1500,
            arrows: false,
            dots: false,
            pauseOnHover: false,
            responsive: [{
                breakpoint: 768,
                settings: {
                    slidesToShow: 4
                }
            }, {
                breakpoint: 520,
                settings: {
                    slidesToShow: 3
                }
            }]
        });
    });
</script>
</body>
</html>