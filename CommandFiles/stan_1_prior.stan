data {
    int N; //number of years
}

generated quantities {
    real theta=gamma(20, 430000);
    int y_sim[N];
    for (k in 1:N) {
        y_sim[k] = poisson_rng(theta);
    }
}
