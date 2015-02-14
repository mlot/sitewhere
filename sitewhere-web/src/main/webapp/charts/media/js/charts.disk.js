var Charts = function () {

    return {
        //main function to initiate the module

        init: function () {

            App.addResponsiveHandler(function () {

            });

        },

        initCharts: function () {

            if (!jQuery.plot) {
                return;
            }

            var disk = [];
            var dataset;
            var totalPoints = 100;
            var updateInterval = 500;
            var now = new Date().getTime();

            var options = {
                series: {
                    lines: {
                        lineWidth: 1.2
                    },
                    bars: {
                        align: "center",
                        fillColor: {colors: [{opacity: 1}, {opacity: 1}]},
                        barWidth: 500,
                        lineWidth: 1
                    }
                },
                xaxis: {
                    mode: "time",
                    tickSize: [1, "second"],
                    tickFormatter: function (v, axis) {
                        var date = new Date(v);

                        if (date.getSeconds() % 10 == 0) {
                            var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
                            var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
                            var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();

                            return hours + ":" + minutes + ":" + seconds;
                        } else {
                            return "";
                        }
                    },

                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 10
                },
                yaxes: [
                    {
                        min: 0,
                        max: 100,
                        tickSize: 10,
                        tickFormatter: function (v, axis) {
                            if (v % 10 == 0) {
                                return v + "%";
                            } else {
                                return "";
                            }
                        },
                        position: "right",
                        axisLabelUseCanvas: true,
                        axisLabelFontSizePixels: 12,
                        axisLabelFontFamily: 'Verdana, Arial',
                        axisLabelPadding: 6
                    }
                ],
                legend: {
                    labelBoxBorderColor: "#4da60c",
                    noColumns: 0,
                    position: "nw"
                },
                grid: {
                    color: "#4da60c",
                    tickColor: "#dbedce",
                    backgroundColor: "#ffffff"
                }
            };

            function initData() {
                for (var i = 0; i < totalPoints; i++) {
                    var temp = [now += updateInterval, 0];
                    disk.push(temp);
                }
            }

            function GetData() {
                FlyJSONP.init({debug: true});
                FlyJSONP.get({
                    url: "http://192.168.1.120/phptest/random.php",
                    success: update,
                    error: function () {
                        setTimeout(GetData, updateInterval);
                    }
                });
            }

            var temp;

            function update(_data) {
                disk.shift();
                now += updateInterval

                temp = [now, _data.disk];
                disk.push(temp);

                dataset = [
                    {
                        label: "Disk:" + _data.disk + "%",
                        data: disk,
                        lines: {fill: true, lineWidth: 0.5},
                        color: "#def9c2"
                    }
                ];

                $.plot($("#disk_1"), dataset, options);
                setTimeout(GetData, updateInterval);
            }

            //Basic Chart

            function chart1() {

                initData();

                dataset = [
                    {label: "Disk", data: disk, lines: {fill: true, lineWidth: 0.5}, color: "#def9c2"}
                ];

                $.plot($("#disk_1"), dataset, options);
                setTimeout(GetData, updateInterval);
            }


            //graph
            chart1();
        }
    };

}();