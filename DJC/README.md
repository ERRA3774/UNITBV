# Greenfoot game

https://github.com/ERRA3774/UNITBV/assets/93817419/86a37df5-5442-4466-bec1-088cf1eac1a3

GameWorld

```java
import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class GameWorld extends World
{
    public static final int GAME_FPS = 60;

    public static int GameTicks;
    public static int ElapsedSeconds;
    public static int AmmoCount;

    public static boolean CanFire;

    public static Player Human;

    public static Cacodemon Cacodemon1;
    public static Cacodemon Cacodemon2;
    public static Cacodemon Cacodemon3;
    public static Cacodemon Cacodemon4;
    public static Cacodemon Cacodemon5;
    public static Cacodemon Cacodemon6;
    
    public GameWorld()
    {    
        super(1600, 900, 1);
        GameTicks = 0;
        DeltaTime = 0;
        ElapsedSeconds = 0;
        CanFire = true;
        AmmoCount = 0;
        Human = new Player();
        Cacodemon1 = new Cacodemon();
        Cacodemon2 = new Cacodemon();
        Cacodemon3 = new Cacodemon();
        Cacodemon4 = new Cacodemon();
        Cacodemon5 = new Cacodemon();
        Cacodemon6 = new Cacodemon();
        prepare();
    }
    
    public void run() {
        Greenfoot.setWorld(new GameWorld());
    }
    
    public void act() {
        GameTicks++;
        ElapsedSeconds = (int) (GameTicks / GAME_FPS);
        showText("Elapsed Time: " + (int) (GameTicks / GAME_FPS), 100, 10);
        showText("Can Fire: " + CanFire, 100, 30);
        showText("Ammo Count: " + AmmoCount, 100, 50);
        showText("Health: " + Human.Health, 100, 70);
        
        if (Human.Health <= 0) {
            showText("GAME OVER", 800, 450);
            Greenfoot.stop();
        }
        
        if (getObjects(Cacodemon.class).isEmpty()) {
            showText("YOU WON!", 800, 450);
            Greenfoot.stop();
        }
    }

    private void prepare()
    {
        addObject(Human,340,430);

        addObject(Cacodemon1,1498,113);
        
        addObject(Cacodemon2,1366,204);
        
        addObject(Cacodemon3,1494,376);
        
        addObject(Cacodemon4,1343,479);
        
        addObject(Cacodemon5,1503,630);
        
        addObject(Cacodemon6,1370,766);
    }
}

```

Player

```java
import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class Player extends Actor
{
    private static int mMoveSpeed;
    private static int mTurnSpeed;
    private static int mAmmoCount;
    private static int mFiredOnTick;
    private static int mReloadOnTick;
    private static int mHealth;
    private static int mDamage;
    
    private static boolean mCanFire;
    private static boolean mIsReloading;
    
    private static double mFireCooldown;
    private static double mReloadCooldown;
    
    public int Health;
    
    public Player() {
        mFiredOnTick = GameWorld.GameTicks;
        mReloadOnTick = GameWorld.GameTicks;
        
        mMoveSpeed = 5;
        mTurnSpeed = 3;
        mAmmoCount = 10;
        mFiredOnTick = 0;
        mReloadOnTick = 0;
        mHealth = 100;
        mDamage = 10;
        
        mCanFire = true;
        mIsReloading = false;
        
        mFireCooldown = 0.1;
        mReloadCooldown = 1.0;
        
        Health = mHealth;
    }
        
    public void act()
    {
        if (Greenfoot.isKeyDown("W") || Greenfoot.isKeyDown("Up")) {
            move(mMoveSpeed);
        }
        
        if (Greenfoot.isKeyDown("A") || Greenfoot.isKeyDown("Left")) {
            turn(-mTurnSpeed);
        }
        
        if (Greenfoot.isKeyDown("S") || Greenfoot.isKeyDown("Down")) {
            move(-mMoveSpeed);
        }
        
        if (Greenfoot.isKeyDown("D") || Greenfoot.isKeyDown("Right")) {
            turn(mTurnSpeed);
        }
        
        if (mIsReloading) {
            boolean finishedReloading = (GameWorld.GameTicks - mReloadOnTick) > (mReloadCooldown * GameWorld.GAME_FPS);
            
            if (finishedReloading) {
                mAmmoCount = 10;
                mIsReloading = false;
                mCanFire = true;
            }
        }
        
        if (mAmmoCount > 0 && !mIsReloading) {
            mCanFire = (GameWorld.GameTicks - mFiredOnTick) > (mFireCooldown * GameWorld.GAME_FPS);
        }
        
        GameWorld.CanFire = mCanFire;
        GameWorld.AmmoCount = mAmmoCount;
        
        if ((Greenfoot.isKeyDown("J") || Greenfoot.isKeyDown("Space")) && mCanFire) {
            Bullet bullet = new Bullet(this.getRotation());    
            getWorld().addObject(bullet, this.getX(), this.getY());
            mCanFire = false;
            mFiredOnTick = GameWorld.GameTicks;
            mAmmoCount--;
            
            if (mAmmoCount <= 0) {
                mReloadOnTick = GameWorld.GameTicks;
                mIsReloading = true;
            }
        }
        
    }
    
    public void decrementHealth() {
        this.Health -= 5;
    }
}

```

Bullet
```java
import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class Bullet extends Actor
{
    private int mMoveSpeed = 15;
    
    public Bullet(int playerRotation) {
        GreenfootImage image = getImage();
        image.scale(image.getWidth() * 60 / 100, image.getHeight() * 60 / 100);
        setRotation(playerRotation);
    }
    
    public void act()
    {
        if (getWorld() != null) {
            move(mMoveSpeed);
        
            if (isAtEdge()) {
                getWorld().removeObject(this);
            } else if (isTouching(Cacodemon.class)) {

                if (intersects(GameWorld.Cacodemon1)) {
                    GameWorld.Cacodemon1.decrementHealth();
                } 
                
                if (intersects(GameWorld.Cacodemon2)) {
                    GameWorld.Cacodemon2.decrementHealth();
                }
                
                if (intersects(GameWorld.Cacodemon3)) {
                    GameWorld.Cacodemon3.decrementHealth();
                }
                
                if (intersects(GameWorld.Cacodemon4)) {
                    GameWorld.Cacodemon4.decrementHealth();
                }
                
                if (intersects(GameWorld.Cacodemon5)) {
                    GameWorld.Cacodemon5.decrementHealth();
                }
                
                if (intersects(GameWorld.Cacodemon6)) {
                    GameWorld.Cacodemon6.decrementHealth();
                }
                
                getWorld().removeObject(this);
            }
        }
    }
}

```

Cacodemon
```java
import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class Cacodemon extends Actor
{
    private boolean facingLeft;
    private boolean facingRight;
    private boolean shouldFire;
    private int moveSpeed;
    
    public int Health;
    
    public Cacodemon() {
        moveSpeed = 1;
        facingLeft = false;
        facingRight = true;
        shouldFire = true;
        Health = 200;
    }
    
    public void act()
    {
        int prevX = this.getX();
        tryTurn();            
        tryMove();
        fire();
        int currX = this.getX();
        
        if (currX - prevX < 0 && !facingLeft) {
            flip();
            facingLeft = true;
            facingRight = false;
        }
            
        if (currX - prevX > 0 && !facingRight) {
            flip();
            facingRight = true;
            facingLeft = false;
        }
        
        if (getX() - GameWorld.Human.getX() <= 800) {
            moveSpeed = 0;
            shouldFire = true;
        }
        
        if (GameWorld.GameTicks % 200 == 0) {
            shouldFire = false;
        }
        
        if (this.Health <= 0) {
            getWorld().removeObject(this);
        }
    }
    
    public void decrementHealth() {
        this.Health -= 10;
    }
    
    private void flip() {
        GreenfootImage image = getImage();
        image.mirrorVertically();
        setImage(image);
    }
    
    private void tryMove() {
        move(moveSpeed);
        if (isTouching(Cacodemon.class)) {
            move(-moveSpeed);
            shouldFire = true;
        }
    }
    
    private void tryTurn() {
        turnTowards(GameWorld.Human.getX(), GameWorld.Human.getY());

        if (isTouching(Cacodemon.class)) {
            turnTowards(-GameWorld.Human.getX(), -GameWorld.Human.getY());
            shouldFire = true;
        }      
    }
    
    private void fire() {
        if (GameWorld.GameTicks % 70 == 0) {
            int playerX = GameWorld.Human.getX();
            int playerY = GameWorld.Human.getY();
            Fireball fireball = new Fireball(playerX, playerY, this.getX(), this.getY());
            getWorld().addObject(fireball, this.getX(), this.getY());
        }
        
        if (GameWorld.GameTicks % 500 == 0) {
            moveSpeed = 3;
        }
    }
    
}

```

Fireball
```java
import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class Fireball extends Actor
{
    private int mMoveSpeed = 10;
    
    public Fireball(int playerX, int playerY, int fireballX, int fireballY) {
        int deltaX = playerX - fireballX;
        int deltaY = playerY - fireballY;
        int angle = (int) Math.toDegrees(Math.atan2(deltaY, deltaX));
        setRotation(angle);
    }
    
    public void act()
    {
        move(mMoveSpeed);
        
        if (isAtEdge()) {
            getWorld().removeObject(this);
        } else if (isTouching(Player.class)) {
            GameWorld.Human.decrementHealth();
            getWorld().removeObject(this);
        }
    }
}
```


