package com.example.jeff_lu.chatapp;

/**
 * Created by jeff_lu on 2017/3/17.
 */

import android.content.Intent;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.app.AlertDialog;
import android.text.Editable;
import android.text.InputFilter;
import android.text.TextWatcher;
import android.support.v4.app.DialogFragment;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;
import android.widget.EditText;


import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.auth.api.signin.GoogleSignInResult;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.SignInButton;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthCredential;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.GoogleAuthProvider;



public class SignInActivity extends AppCompatActivity implements
        GoogleApiClient.OnConnectionFailedListener, View.OnClickListener {

    private static final String TAG = "SignInActivity";
    private static final int RC_SIGN_IN = 8888;
    public static final int DEFAULT_MSG_LENGTH_LIMIT = 10;

    private SharedPreferences mSharedPreferences;
    private SignInButton mSignInButton;
    private Button mSendButton;
    private EditText mMessageEditText;
    private  EditText mPasswordEditText;

    private View view;
    private String userUID;
    private Boolean account = false;
    private Boolean Password = false;
    private Boolean success = false;
    private GoogleApiClient mGoogleApiClient;

    // Firebase instance variables
    private FirebaseAuth mFirebaseAuth;
    private FirebaseAuth.AuthStateListener authListener;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_in);

        mSharedPreferences = PreferenceManager.getDefaultSharedPreferences(this);
        // Assign fields
        mSignInButton = (SignInButton) findViewById(R.id.sign_in_button);
        mSendButton = (Button) findViewById(R.id.button);
        mSendButton.setEnabled(false);
        mSendButton.setTextColor(Color.WHITE);
        // Set click listeners
        mSignInButton.setOnClickListener(this);

        // Configure Google Sign In
        GoogleSignInOptions gso = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
                .requestIdToken(getString(R.string.default_web_client_id))
                .requestEmail()
                .build();
        mGoogleApiClient = new GoogleApiClient.Builder(this)
                .enableAutoManage(this /* FragmentActivity */, this /* OnConnectionFailedListener */)
                .addApi(Auth.GOOGLE_SIGN_IN_API, gso)
                .build();

        // Initialize FirebaseAuth
        mFirebaseAuth = FirebaseAuth.getInstance();
        authListener = new FirebaseAuth.AuthStateListener() {
            @Override
            public void onAuthStateChanged(
                    @NonNull FirebaseAuth firebaseAuth) {
                FirebaseUser user = firebaseAuth.getCurrentUser();
                if (user!=null) {
                    Log.d("onAuthStateChanged", "登入:"+
                            user.getUid());
                    userUID = user.getUid();
                }else{
                    Log.d("onAuthStateChanged", "已登出");
                }
            }
        };

        mMessageEditText = (EditText) findViewById(R.id.email);
        mMessageEditText.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                if (charSequence.toString().trim().length() > 0 && Password) {
                    account = true;
                    mSendButton.setEnabled(true);
                }
                else if (charSequence.toString().trim().length() > 0 && !Password){
                    account = true;
                }
                else {
                    account = false;
                    mSendButton.setEnabled(false);
                }
            }
            @Override
            public void afterTextChanged(Editable editable) {
            }
        });

        mPasswordEditText = (EditText) findViewById(R.id.password);
        mPasswordEditText.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                if (charSequence.toString().trim().length() > 0 && account) {
                    Password = true;
                    mSendButton.setEnabled(true);
                }
                else if (charSequence.toString().trim().length() > 0 && !account){
                    Password = true;
                }
                else {
                    Password = false;
                    mSendButton.setEnabled(false);
                }
            }
            @Override
            public void afterTextChanged(Editable editable) {
            }
        });


    }

    @Override
    protected void onStart() {
        super.onStart();
        mFirebaseAuth.addAuthStateListener(authListener);

    }

    @Override
    protected void onStop() {
        super.onStop();
        mFirebaseAuth.removeAuthStateListener(authListener);
    }

    //Email login
    public void login(View v){
        final String email = ((EditText)findViewById(R.id.email))
                .getText().toString();
        final String password = ((EditText)findViewById(R.id.password))
                .getText().toString();
        Log.d("AUTH", email+"/"+password);
        if(email!="" && password!="") {
            mFirebaseAuth.signInWithEmailAndPassword(email, password)
                    .addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                        @Override
                        public void onComplete(@NonNull Task<AuthResult> task) {
                            if (!task.isSuccessful()) {
                                Log.d("onComplete", "登入失敗");
                                register(email, password);
                            }
                            else{
                                Intent signInIntent = new Intent();
                                signInIntent.setClass(SignInActivity.this,MainActivity.class);
                                startActivity(signInIntent);
                            }
                        }
                    });
        }
    }

    //register
    private void register(final String email, final String password) {
        final AlertDialog.Builder alert = new AlertDialog.Builder(SignInActivity.this);
                alert.setTitle("登入問題")
                .setMessage("無此帳號，是否要以此帳號與密碼註冊?")
                .setPositiveButton("註冊",
                        new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                createUser(email, password);
                            }
                        })
                .setNeutralButton("取消", null)
                .show();




    }

    //createUser
    private void createUser(String email, String password) {

        mFirebaseAuth.createUserWithEmailAndPassword(email, password)
                .addOnCompleteListener(
                        new OnCompleteListener<AuthResult>() {
                            @Override
                            public void onComplete(@NonNull Task<AuthResult> task) {
                                if (task.isSuccessful()){
                                    success = true;
                                    Log.d("debug","success1");
                                }
                                String message =
                                        task.isSuccessful() ? "註冊成功" : "註冊失敗";
                                new AlertDialog.Builder(SignInActivity.this)
                                        .setMessage(message)
                                        .setPositiveButton("OK", null)
                                        .show();
                                if(success){
                                    Log.d("debug","success2");
                                    login(view);
                                }
                            }

                        });


    }


    //Google sign in
    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.sign_in_button:
                signIn();
                break;
        }
    }

    @Override
    public void onConnectionFailed(@NonNull ConnectionResult connectionResult) {
        // An unresolvable error has occurred and Google APIs (including Sign-In) will not
        // be available.
        Log.d(TAG, "onConnectionFailed:" + connectionResult);
        Toast.makeText(this, "Google Play Services error.", Toast.LENGTH_SHORT).show();
    }

    private void signIn() {
        Intent signInIntent = Auth.GoogleSignInApi.getSignInIntent(mGoogleApiClient);
        startActivityForResult(signInIntent, RC_SIGN_IN);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        // Result returned from launching the Intent from GoogleSignInApi.getSignInIntent(...);
        if (requestCode == RC_SIGN_IN) {
            GoogleSignInResult result = Auth.GoogleSignInApi.getSignInResultFromIntent(data);
            if (result.isSuccess()) {
                // Google Sign-In was successful, authenticate with Firebase
                GoogleSignInAccount account = result.getSignInAccount();
                firebaseAuthWithGoogle(account);
            } else {
                // Google Sign-In failed
                Log.e(TAG, "Google Sign-In failed.");
            }
        }
    }

    private void firebaseAuthWithGoogle(GoogleSignInAccount acct) {
        Log.d(TAG, "firebaseAuthWithGooogle:" + acct.getId());
        AuthCredential credential = GoogleAuthProvider.getCredential(acct.getIdToken(), null);
        mFirebaseAuth.signInWithCredential(credential)
                .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
                    @Override
                    public void onComplete(@NonNull Task<AuthResult> task) {
                        Log.d(TAG, "signInWithCredential:onComplete:" + task.isSuccessful());

                        // If sign in fails, display a message to the user. If sign in succeeds
                        // the auth state listener will be notified and logic to handle the
                        // signed in user can be handled in the listener.
                        if (!task.isSuccessful()) {
                            Log.w(TAG, "signInWithCredential", task.getException());
                            Toast.makeText(SignInActivity.this, "Authentication failed.",
                                    Toast.LENGTH_SHORT).show();
                        } else {
                            startActivity(new Intent(SignInActivity.this, MainActivity.class));
                            finish();
                        }
                    }
                });
    }
}

