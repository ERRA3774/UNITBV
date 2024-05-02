# XOGL

```txt
Tema 1 – MVP ID 

Se cere să se scrie o aplicație reprezentând un Joc “X şi O”. Aplicația va fi 
implementată în limbajul C#, obligatoriu de tip WPF, platforma .NET Framework 4.5+, 
Visual Studio 2019 (sau mai nou). Opțional, aplicația poate fi dezvoltată cu design pattern-ul MVVM. 

Va exista un meniu „Joc” cu un submeniu “Start Joc”, şi un meniu „Ajutor”, care va 
conţine un submeniu "Despre", cu: numele studentului, adresa de e-mail, data curentă 
preluată din sistem şi o scurtă descriere a jocului. 
La selectarea din meniul ‚Joc’ a submeniului “Start Joc” se va solicita introducerea 
numelui jucătorului şi a simbolului cu care se doreşte a juca (X sau O).  
Jocul va fi compus dintr-un grid de 3 linii şi 3 coloane, iar la click pe una dintre căsuţe 
se va completa simbolul selectat la început (X sau O). După fiecare simbol plasat manual, 
simbolul opus va fi plasat automat, în mod aleatoriu, pe unul dintre câmpurile rămase, după o secundă de aşteptare. Apoi, mutarea jucătorului se va efectua doar atunci când utilizatorul dă click pe una dintre căsuţele libere. Aplicaţia trebuie să marcheze vizual jucătorul care este la mutare. 

Finalul jocului – la completarea unei linii, coloane sau diagonale cu 3 simboluri alese 
de utilizator, jocul se va încheia cu mesajul: „Numele jucătorului, ai câştigat!;  altfel, la completarea unei linii, coloane sau diagonale cu 3 simboluri opuse, se va afişa un mesaj de joc pierdut („Numele jucătorului, ai pierdut!”). În cazul în care toate cele 9 căsuţe sunt completate şi jocul nu s-a încheiat cu câştig sau pierdere, se va afişa un mesaj de egalitate. 

Barem de notare: 
1. Afişarea meniului şi a tablei de joc (2p) 
2. Interschimbarea corectă a adversarilor (1p) 
3. Completarea la click a simbolului ales de utilizator (1p) 
4. Completarea simbolului opus automat (1p) 
5. Identificare sfârşit de joc (2p) 
6. Separarea interfeţei grafice de funcţionalitate (2p) 
7. Oficiu (1p) 

```

```txt
Project Root
    \_ Assets
        \__ icon.ico
        \__ player_o.png
        \__ player_o_transparent.png
        \__ player_x.png
        \__ player_x_transparent.png
    \_ Models
        \__ Board.cs
        \__ User.cs
        \__ Game.cs
    \_ Resources
        \__ Styles.xaml
    \_ Utils
        \__ GameConstants.xaml
    \_ Views
        \__ UserSetupView.xaml
        \__ UserSetupView.xaml.cs
        \__ GameView.xaml
        \__ GameView.xaml.cs
    \_ App.xaml
    \_ App.xaml.cs
    \_ AssemblyInfo.cs
    \_ MainWindow.xaml
    \_ MainWindow.xaml.cs
```

![](start.png)
Start screen

![](new_game.png)
New Game screen

![](game.png)
Game screen

Board

```cs
using XOGL.Utils;

namespace XOGL.Models
{
    public class Board
    {
        private int[,] _grid;
        private int _dimension;

        public struct Cell
        {
            public int Row;
            public int Col;

            public Cell(int row, int col)
            {
                Row = row;
                Col = col;
            }
        }

        private List<Cell> _remainingSpots;
        public List<Cell> RemainingSpots => _remainingSpots;
        public Board()
        {
            _dimension = XOConstants.GRID_DIMENSION;
            _grid = new int[XOConstants.GRID_DIMENSION, XOConstants.GRID_DIMENSION];
            _remainingSpots = new List<Cell>();
            Initialize();
        }

        private void Initialize()
        {
            for (int row = 0; row < _dimension; row++)
            {
                for (int col = 0; col < _dimension; col++)
                {
                    _grid[row, col] = XOConstants.PLAYER_NONE;
                    _remainingSpots.Add(new Cell(row, col));
                }
            }
        }

        public bool MakeMove(int row, int col, int player)
        {
            if (_grid[row, col] == 0)
            {
                _grid[row, col] = player;
                Cell spot = _remainingSpots.Find(spot => spot.Row == row && spot.Col == col);
                _remainingSpots.Remove(spot);
                return true;
            }

            return false;
        }

        public bool GameWonBy(int player)
        {
            if (MatchOnMainDiagonal(player))
            {
                return true;
            }

            if (MatchOnSecondaryDiagonal(player))
            {
                return true;
            }

            if (MatchOnAnyRowOrColumn(player))
            {
                return true;
            }

            return false;
        }

        public bool GameDraw()
        {
            for (int row = 0; row < _dimension; row++)
            {
                for (int col = 0; col < _dimension; col++)
                {
                    if (_grid[row, col] == XOConstants.PLAYER_NONE)
                    {
                        return false;
                    }

                }
            }

            return true;
        }

        private bool MatchOnMainDiagonal(int player)
        {
            return _grid[0, 0] == player && _grid[1, 1] == player && _grid[2, 2] == player;
        }

        private bool MatchOnSecondaryDiagonal(int player)
        {
            return _grid[0, 2] == player && _grid[1, 1] == player && _grid[2, 0] == player;
        }

        private bool MatchOnAnyRowOrColumn(int player)
        {
            for (int i = 0; i < _dimension; i++)
            {
                if (_grid[i, 0] == player && _grid[i, 1] == player && _grid[i, 2] == player)
                {
                    return true;
                }

                if (_grid[0, i] == player && _grid[1, i] == player && _grid[2, i] == player)
                {
                    return true;
                }
            }

            return false;
        }
    }
}

```

User

```cs
using XOGL.Utils;

namespace XOGL.Models
{
    public class User
    {
        private string _name; 
        public string Name
        {
            get => _name; 
            set => _name = value;
        }

        private int _mark;
        public int Mark
        {
            get => _mark;
            set => _mark = value;
        }

        public User()
        {
            _name = XOConstants.USER_UNNAMED;
            _mark = XOConstants.PLAYER_NONE;
        }

        public User(string name, int mark)
        {
            _name = name;
            _mark = mark;
        }
    }
}

```

Game
```cs
using System.Windows;
using System.Windows.Threading;
using XOGL.Utils;

namespace XOGL.Models
{
    public class XOGame
    {
        private Board _board;
        public Board Board => _board;

        private User _user;
        public User User => _user;

        private int _computerPlayer;
        public int ComputerPlayer => _computerPlayer;

        private int _playerOnTurn;
        public int PlayerOnTurn => _playerOnTurn;

        private State _gameState;
        public State GameState => _gameState;

        public XOGame(User user)
        {
            _board = new Board();
            _user = user;
            _computerPlayer = _user.Mark == XOConstants.PLAYER_X ? XOConstants.PLAYER_O : XOConstants.PLAYER_X;
            _gameState = _user.Mark == XOConstants.PLAYER_X ? State.UserToMove : State.ComputerToMove;
            _playerOnTurn = XOConstants.PLAYER_X;
        }

        public void UserMove(int row, int col)
        {
            _board.MakeMove(row, col, _user.Mark);
            PassTurn();
        }

        public Board.Cell ComputerMove()
        {
            Random random = new Random();
            Board.Cell randomSpot = _board.RemainingSpots[random.Next(_board.RemainingSpots.Count)];
            _board.MakeMove(randomSpot.Row, randomSpot.Col, _computerPlayer);
            PassTurn();
            return randomSpot;
        }

        private void PassTurn()
        {
            _playerOnTurn = _playerOnTurn == XOConstants.PLAYER_X ? XOConstants.PLAYER_O : XOConstants.PLAYER_X;
        }

        public enum State
        {
            UserToMove,
            ComputerToMove,
            Won,
            Lost,
            Draw
        }

        public State SetState()
        {
            if (_board.GameWonBy(_user.Mark))
            {
                return State.Won;
            }
            else if (_board.GameWonBy(_computerPlayer))
            {
                return State.Lost;
            }
            else if (_board.GameDraw())
            {
                return State.Draw;
            }
            else if (_playerOnTurn == _computerPlayer)
            {
                return State.ComputerToMove;
            }
            else
            {
                return State.UserToMove;
            }
        }
    }
}

```

Styles

```xml
<ResourceDictionary xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">

    <Style TargetType="Button" x:Key="GridButtonStyle">
        <Setter Property="Template">
            <Setter.Value>
                <ControlTemplate TargetType="Button">
                    <Border 
                        Height="100"
                        Width="100"
                        Background="Transparent"
                        Padding="5"
                        BorderThickness="2">

                        <Border.BorderBrush>
                            <SolidColorBrush Color="#E1E1E1"/>
                        </Border.BorderBrush>

                        <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                    </Border>
                </ControlTemplate>
            </Setter.Value>
        </Setter>
    </Style>

    <Style TargetType="Button" x:Key="ProfileButtonStyle">
        <Setter Property="Template">
            <Setter.Value>
                <ControlTemplate TargetType="Button">
                    <Border 
                        Height="40"
                        Background="Transparent"
                        BorderThickness="0">

                        <Border.BorderBrush>
                            <SolidColorBrush Color="White"/>
                        </Border.BorderBrush>

                        <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                    </Border>
                </ControlTemplate>
            </Setter.Value>
        </Setter>
    </Style>

</ResourceDictionary>
```

User Setup View

```xml
<UserControl x:Class="XOGL.Views.UserSetupView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:XOGL.Views"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="800">
    
    <Grid Name ="GrdProfile" HorizontalAlignment="Center" VerticalAlignment="Center" Grid.IsSharedSizeScope="True">
        <Grid.RowDefinitions>
            <RowDefinition Height="auto"/>
            <RowDefinition Height="auto"/>
            <RowDefinition Height="auto"/>
        </Grid.RowDefinitions>

        <Grid Grid.Row="0" HorizontalAlignment="Center" VerticalAlignment="Center">
            <TextBlock Text="New Game" FontSize="40">
                <TextBlock.Foreground>
                    <SolidColorBrush Color="White"/>
                </TextBlock.Foreground>
            </TextBlock>
        </Grid>

        <Grid Grid.Row="1" HorizontalAlignment="Right" VerticalAlignment="Center" Margin="0 20">

            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="auto" SharedSizeGroup="FirstColumn"/>
                <ColumnDefinition Width="auto" SharedSizeGroup="SecondColumn"/>
            </Grid.ColumnDefinitions>

            <Label Name="LblProfileName"
                   HorizontalAlignment="Right"
                   Content="Name" 
                   BorderThickness="0"
                   FontSize="20">

                <Label.Foreground>
                    <SolidColorBrush Color="White"/>
                </Label.Foreground>

            </Label>

            <TextBox Name="TbInput"
                     Grid.Row="0"
                     Grid.Column="1"
                     FontSize="16"
                     Margin="40, 0"
                     Padding="10"
                     Width="300"
                     Foreground="White"
                     Background="Transparent">
            </TextBox>
        </Grid>

        <Grid Grid.Row="2" HorizontalAlignment="Right" VerticalAlignment="Center">

            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="auto" SharedSizeGroup="FirstColumn"/>
                <ColumnDefinition Width="auto" SharedSizeGroup="SecondColumn"/>
            </Grid.ColumnDefinitions>

            <Label Name="LblProfilePlayer"
                    HorizontalAlignment="Center"
                    Content="Mark" 
                    FontSize="20">

                <Label.Foreground>
                    <SolidColorBrush Color="White"/>
                </Label.Foreground>

            </Label>

            <StackPanel Grid.Row="0" Grid.Column ="1" Orientation="Horizontal" Margin="40, 0">

                <Button Style="{StaticResource ProfileButtonStyle}"
                        Click="Button_ClickProfileX"
                        >
                    <Image 
                        Source="../Assets/X.png"
                        Cursor="Hand">
                    </Image>
                </Button>

                <Button Style="{StaticResource ProfileButtonStyle}" 
                        Click="Button_ClickProfileO"
                        Margin="50 5">
                    <Image 
                        Source="../Assets/O.png" 
                        Cursor="Hand">
                    </Image>
                </Button>
            </StackPanel>

        </Grid>

    </Grid>
</UserControl>

```

User Setup View
```cs
using System.Windows;
using System.Windows.Controls;
using XOGL.Utils;
using XOGL.Models;

namespace XOGL.Views
{
    /// <summary>
    /// Interaction logic for UserSetupView.xaml
    /// </summary>
    public partial class UserSetupView : UserControl
    {
        public UserSetupView()
        {
            InitializeComponent();
        }

        private void Button_ClickProfileX(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(TbInput.Text))
            {
                MessageBox.Show(XOConstants.UNNAMED_USER_ERROR_MESSAGE);
                return;
            }

            Execute(XOConstants.PLAYER_X);
        }

        private void Button_ClickProfileO(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(TbInput.Text))
            {
                MessageBox.Show(XOConstants.UNNAMED_USER_ERROR_MESSAGE);
                return;
            }

            Execute(XOConstants.PLAYER_O);
        }

        private void Execute(int mark)
        {
            User user = new User(TbInput.Text, mark);
            XOGame game = new XOGame(user);
            XOGameView gameView = new XOGameView(game);
            GrdProfile.Children.Clear();
            GrdProfile.Children.Add(gameView);
        }
    }
}

```

Game View

```xml
<UserControl x:Class="XOGL.Views.XOGameView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="800">

    <Grid Name="GrdBoard" HorizontalAlignment="Center" VerticalAlignment="center">
        
        <Grid.RowDefinitions>
            <RowDefinition Height="auto"/>
            <RowDefinition Height="auto"/>
            <RowDefinition Height="auto"/>
        </Grid.RowDefinitions>

        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="auto"/>
            <ColumnDefinition Width="auto"/>
            <ColumnDefinition Width="auto"/>
        </Grid.ColumnDefinitions>

        <Button Name="Btn00" 
            Grid.Row="0" 
            Grid.Column="0"
            Style="{StaticResource GridButtonStyle}"
            Click="Button_Click"
            MouseEnter="Button_MouseEnter" 
            MouseLeave="Button_MouseLeave"
            IsEnabled="True"
                
            />

        <Button Name="Btn01" 
            Grid.Row="0" 
            Grid.Column="1" 
            Style="{StaticResource GridButtonStyle}"
            Click="Button_Click"

            MouseEnter="Button_MouseEnter" 
            MouseLeave="Button_MouseLeave"
            IsEnabled="True"
                
            />


        <Button Name="Btn02" 
            Grid.Row="0" 
            Grid.Column="2" 
            Style="{StaticResource GridButtonStyle}" 
            Click="Button_Click"

            MouseEnter="Button_MouseEnter" 
            MouseLeave="Button_MouseLeave"
            IsEnabled="True"
            />

        <Button Name="Btn10" 
            Grid.Column="0" 
            Grid.Row="1" 
            Style="{StaticResource GridButtonStyle}"
            Click="Button_Click"

            MouseEnter="Button_MouseEnter" 
            MouseLeave="Button_MouseLeave"
            IsEnabled="True"
            />

        <Button Name="Btn11" 
            Grid.Row="1" 
            Grid.Column="1" 
            Style="{StaticResource GridButtonStyle}"
            Margin="5" 
            Click="Button_Click"
             
            MouseEnter="Button_MouseEnter" 
            MouseLeave="Button_MouseLeave"
            IsEnabled="True"
            />


        <Button Name="Btn12" 
            Grid.Row="1" 
            Grid.Column="2" 
            Style="{StaticResource GridButtonStyle}"  
            Click="Button_Click"
             
            MouseEnter="Button_MouseEnter" 
            MouseLeave="Button_MouseLeave"
            IsEnabled="True"
            />

        <Button Name="Btn20" 
            Grid.Row="2" 
            Grid.Column="0" 
            Style="{StaticResource GridButtonStyle}"
            Click="Button_Click"
             
            MouseEnter="Button_MouseEnter" 
            MouseLeave="Button_MouseLeave"
            IsEnabled="True"
                
            />

        <Button Name="Btn21" 
            Grid.Row="2" 
            Grid.Column="1" 
            Style="{StaticResource GridButtonStyle}"
            Click="Button_Click"
             
            MouseEnter="Button_MouseEnter" 
            MouseLeave="Button_MouseLeave"
            IsEnabled="True"
                
            />

        <Button Name="Btn22" 
            Grid.Row="2" 
            Grid.Column="2" 
            Style="{StaticResource GridButtonStyle}"
            Click="Button_Click"
            
            MouseEnter="Button_MouseEnter" 
            MouseLeave="Button_MouseLeave"
            IsEnabled="True"
                
            />
    </Grid>

</UserControl>

```

Game View

```cs
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Imaging;

using XOGL.Utils;
using XOGL.Models;
using System.Windows.Threading;

namespace XOGL.Views
{
    public partial class XOGameView : UserControl
    {
        private XOGame _game;
        private string _userMark;
        private string _userHover;
        private string _computerMark;
        private string _computerHover;
        private List<Button> _enabledButtons;

        public XOGameView(XOGame game)
        {
            InitializeComponent();
            StartGame(game.User);
        }

        private void StartGame(User user)
        {
            _game = new XOGame(user);
            _userMark = user.Mark == XOConstants.PLAYER_X ? XOConstants.X_IMG : XOConstants.O_IMG;
            _userHover = user.Mark == XOConstants.PLAYER_X ? XOConstants.X_IMG_T : XOConstants.O_IMG_T;
            _computerMark = user.Mark == XOConstants.PLAYER_X ? XOConstants.O_IMG : XOConstants.X_IMG;
            _computerHover = user.Mark == XOConstants.PLAYER_X ? XOConstants.O_IMG_T : XOConstants.X_IMG_T;
            _enabledButtons = new List<Button>(9);

            foreach (Button button in GrdBoard.Children)
            {
                button.IsEnabled = true;
                button.Content = null;
                _enabledButtons.Add(button);
            }

            OnStateChanged(_game.SetState());
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Button button = sender as Button;
            int row = Grid.GetRow(button);
            int col = Grid.GetColumn(button);

            if (button != null)
            {
                _game.UserMove(row, col);

                button.Content = new Image
                {
                    Source = new BitmapImage(new Uri(_userMark, UriKind.Relative)),
                };
                button.IsEnabled = false;
                _enabledButtons.Remove(button);
            }   

            OnStateChanged(_game.SetState());
        }

        private void OnComputerMove()
        {
            Board.Cell cellPicked = _game.ComputerMove();
            Button buttonPicked = FindButtonOnGrid(cellPicked.Row, cellPicked.Col);

            SimulateComputerHover(buttonPicked);

            buttonPicked.IsEnabled = false;
            _enabledButtons.Remove(buttonPicked);

            OnStateChanged(_game.SetState());
        }

        private void SimulateComputerHover(Button buttonPicked)
        {
            var hoverTimer = new DispatcherTimer { Interval = TimeSpan.FromMilliseconds(200) };

            foreach (Button button in _enabledButtons)
            {
                hoverTimer.Start();

                button.Content = new Image { Source = new BitmapImage(new Uri(_computerHover, UriKind.Relative)) };

                hoverTimer.Tick += (sender, args) =>
                {
                    hoverTimer.Stop();

                    button.Content = null;
                };
            }

            var playTimer = new DispatcherTimer { Interval = TimeSpan.FromSeconds(XOConstants.DELAY_SECONDS) };
            playTimer.Start();
            playTimer.Tick += (sender, args) =>
            {
                playTimer.Stop();
                buttonPicked.Content = new Image
                {
                    Source = new BitmapImage(new Uri(_computerMark, UriKind.Relative)),
                };
            };
        }

        private Button FindButtonOnGrid(int row, int col)
        {
            foreach (Button button in _enabledButtons)
            {
                if (Grid.GetRow(button) == row && Grid.GetColumn(button) == col)
                {
                    return button;
                }
            }

            return null;
        }

        private void Button_MouseEnter(object sender, RoutedEventArgs e)
        {
            Button button = sender as Button;

            if (button != null && button.IsEnabled == true)
            {
                button.Content = new Image
                {
                    Source = new BitmapImage(new Uri(_userHover, UriKind.Relative))
                };
            }
        }

        private void Button_MouseLeave(object sender, RoutedEventArgs e)
        {
            Button button = sender as Button;

            if (button != null && button.IsEnabled == true)
            {
                button.Content = null;
            }
        }

        private void OnStateChanged(XOGame.State state)
        {
            switch (state)
            {
                case XOGame.State.Won:
                    MessageBox.Show($"{_game.User.Name} ai castigat!");
                    StartGame(_game.User);
                    break;

                case XOGame.State.Lost:
                    MessageBox.Show($"{_game.User.Name} ai pierdut!");
                    StartGame(_game.User);
                    break;

                case XOGame.State.Draw:
                    MessageBox.Show($"Egalitate!");
                    StartGame(_game.User);
                    break;

                case XOGame.State.ComputerToMove:
                    OnComputerMove();
                    break;
            }
        }
    }
}

```

App

```xml
<Application x:Class="XOGL.App"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:local="clr-namespace:XOGL"
             StartupUri="MainWindow.xaml">
    <Application.Resources>
        <ResourceDictionary>
            <ResourceDictionary.MergedDictionaries>
                <ResourceDictionary Source="Resources/Styles.xaml"/>
            </ResourceDictionary.MergedDictionaries>
        </ResourceDictionary>
    </Application.Resources>
</Application>

```

Main Window
```xml
<Window x:Class="XOGL.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        mc:Ignorable="d"
        Title="XOGL" 
        Height="576"
        Width="1024"
        ResizeMode="NoResize"
        WindowStartupLocation="CenterScreen">

    <Window.Background>
        <SolidColorBrush Color="#1E1E1E"/>
    </Window.Background>

    <Grid>

        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>

        <Menu Name="MenuTop">

            <MenuItem Cursor="Hand" Header="_Joc">
                <MenuItem Header="Start Joc" Click="MenuItem_NewGame"/>
                <Separator/>
                <MenuItem Header="Inchide" Click="MenuItem_Exit"/>
            </MenuItem>

            <MenuItem Cursor="Hand" Header="_Ajutor" >
                <MenuItem Name="MenuAbout" Cursor="Hand" Header="Despre">

                </MenuItem>
            </MenuItem>

        </Menu>

        <Grid Name ="GrdView" Grid.Row="1">

            <TextBlock Foreground="White" 
                       Name="TbStartMessage"
                       HorizontalAlignment="Center" 
                       VerticalAlignment="Center"
                       FontStretch="ExtraExpanded"
                       FontSize="50"
                       Text="XOGL :: Click Joc -> Start joc">

            </TextBlock>
        </Grid>

    </Grid>
</Window>

```

Main Window

```cs
using System.Windows;
using System.Windows.Controls;

using XOGL.Views;
using XOGL.Utils;

namespace XOGL
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private UserControl _currentView;

        public MainWindow()
        {
            InitializeComponent();
            InitializeMenuAbout();
        }

        private void MenuItem_NewGame(object sender, RoutedEventArgs e)
        {
            if (_currentView != null)
            {
                GrdView.Children.Remove(_currentView);
            }

            GrdView.Children.Remove(TbStartMessage);

            _currentView = new UserSetupView();
            GrdView.Children.Add(_currentView);
        }

        private void MenuItem_Exit(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void InitializeMenuAbout()
        {
            MenuAbout.Items.Add(XOConstants.DEV_LAST_NAME);
            MenuAbout.Items.Add(XOConstants.DEV_FIRST_NAME);
            MenuAbout.Items.Add(XOConstants.DEV_EMAIL_ADDRESS);
            MenuAbout.Items.Add(XOConstants.SHORT_DESCRIPTION);
            MenuAbout.Items.Add(DateTime.Now.ToString("dddd, MMM dd yyyy, hh:mm:ss"));
        }
    }
}
```