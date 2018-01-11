const path = require('path');

module.exports = {
    entry: {
        app: [
            './resources/index.js',
        ]
    },
    output: {
        path: path.resolve(__dirname + '/docs'),
        filename: '[name].js',
    },
    module: {
        loaders: [
            {
                test: /\.(css|scss)$/,
                use: [
                    'style-loader',
                    'css-loader',
                    'sass-loader',
                ]
            },
            {
                test: /\.html$/,
                exclude: /node_modules/,
                loader: 'file-loader?name=[name].[ext]',
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader: 'elm-webpack-loader?verbose=true&warn=true',
            },
        ],
        noParse: /\.elm$/
    },
    devServer: {
        inline: true,
        stats: { colors: true },
    }
};
