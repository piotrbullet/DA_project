data {
    int N;
    vector [N] sqft;
    int grade[N];
}

generated quantities {
    real alpha =  normal_rng(360000, 150000); // taken from the mean value of the prices
    real beta_sqft = normal_rng(210, 100);
    vector [6] beta_grade;
    for (i in 1:6) {
        beta_grade[i] = normal_rng(100000, 50000);
    }
    real sigma = exponential_rng(0.01);
    vector [N] price;
    for (i in 1:N) {
        price[i] = normal_rng(alpha + sqft[i]*beta_sqft + beta_grade[grade[i]+1], sigma);
    }
}