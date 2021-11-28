<?php
class Database
{
    public $conn;
    protected $hostname = "localhost";
    protected $username = "root";
    protected $password = "";
    protected $dbname = 'e_commerce';
    function __construct()
    {
        $this->conn = mysqli_connect($this->hostname, $this->username, $this->password, $this->dbname) or die('Can\'t connect to database');
        mysqli_set_charset($this->conn, 'utf8');
    }
    function __destruct()
    {
        if ($this->conn) {
            mysqli_close($this->conn);
        }
    }
    function query($sql = '')
    {
        return mysqli_query($this->conn, $sql);
    }
    function get_list($sql = '')
    {
        $data = [];
        $result = $this->query($sql);
        if ($result) {
            while ($row = mysqli_fetch_assoc($result)) {
                $data[] = $row;
            }
        }
        return $data;
    }
    function get_one($sql = '')
    {
        $result = $this->query($sql);
        $data = '';
        if ($result) {
            $data = mysqli_fetch_assoc($result);
        }
        return $data;
    }
}
